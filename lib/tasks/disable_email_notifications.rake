# frozen_string_literal: true

require 'ruby-progressbar'

@verbose = ENV['VERBOSE'].to_s == 'true'
if @verbose
  Rails.logger = Logger.new(STDOUT)
else
  Rails.logger = Logger.new("log/disable_email_on_notification-#{Time.now.strftime '%Y-%m-%d-%H:%M:%S'}.log")
end

desc "Usage: rake disable_email_notifications FILE='<filename.csv>'"
task disable_email_notifications: :environment do
  @file = check_file(ENV['FILE'])
  emails = File.readlines(@file, chomp: true)

  if @verbose
    progressbar = ProgressBar.create(
      title: 'Switching email on notification ',
      total: emails.count,
      format: '%t%e%B%p%%'
    )
  end

  emails.each do |email|
    progressbar.increment if @verbose
    user = Decidim::User.find_by(email: email)
    next if user.nil?
    user.update!(
      email_on_notification: false,
      newsletter_notifications: false
    )
    Rails.logger.debug "Email on notification set to false for user: #{user.nickname}, email: #{user.email}"
  end
  Rails.logger.close
end

private

def check_file(env_file)
  return env_file if File.file?(env_file) && File.readable?(env_file)
  puts 'Error: You must provide a valid and readable file'
  exit 1
end
