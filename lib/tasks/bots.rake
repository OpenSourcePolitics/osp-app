# frozen_string_literal: true

require 'ruby-progressbar'


namespace :decidim do
  desc 'Deletes User records for bots, usage decidim:clean_bots force=(y/n) log=(false/default -> true)'
  task clean_bots: :environment do
    force = ENV['force']
    @log = ENV['log']

    @logger = Logger.new(Rails.root.join("log", "clean-bots-#{Time.now.strftime '%Y-%m-%d-%H:%M:%S'}.log")) unless @log == "false"

    def log(line)
      puts line
      @logger.info(line) unless @log == "false"
    end

    begin
      bots = Decidim::User.where(deleted_at: nil, sign_in_count: 1)
      bots = bots.where.not(about: nil, personal_url: nil)

      total_bots = 0
      total_activities = 0
      total_reports = 0
      total_comments = 0
      total_messages = 0

      bots.find_each(batch_size: 1000) do |user|
        log('--------------------------------------------------')
        log("\u{1f194} #{user.id} - @#{user.nickname}")
        log('' "#{user.name}" " <#{user.email}>")
        log("\u{1f517} #{user.personal_url}")
        log("\u{1f4dd} #{user.about.truncate(25)}")

        activities = Decidim::ActionLog.where(user: user).count
        reports = Decidim::Report.where(user: user).count
        comments = Decidim::Comments::Comment.where(author: user).count
        messages = Decidim::Messaging::Message.where(sender: user).count

        log('-----------------------------------')
        log("|   \u{2705}   |   \u{1f6a9}   |   \u{1f4ac}   |   \u{1f4e7}   |")
        log('-----------------------------------')
        log("|  #{format('%5.5s', activities)} | #{format('%5.5s', reports)} |  #{format('%5.5s', comments)} | #{format('%5.5s', messages)} |")
        # log("\u{26a0} #{activities}")
        # log("\u{1f6a9} #{reports}")
        # log("\u{1f4ac} #{comments}")
        # log("\u{2709} #{messages}")
        log("--------------------------------------------------")

        total_activities = activities
        total_reports = reports
        total_comments = comments
        total_messages = messages
        total_bots += 1
      end

      log('--------------------------------------------------')
      log("  TOTAL : #{total_bots} bots detected")
      log('-----------------------------------')
      log("|   \u{2705}   |   \u{1f6a9}   |   \u{1f4ac}   |   \u{1f4e7}   |")
      log('-----------------------------------')
      log("|  #{format('%5.5s', total_activities)} | #{format('%5.5s', total_reports)} |  #{format('%5.5s', total_comments)} |) #{format('%5.5s', total_messages)} |")
      log("--------------------------------------------------")

      begin
        log("\u{26a0} Are you sure you want to ANONYMIZE these users \u{2049} (y/n)")
        anonymize = %w[y n].include?(force) ? force : STDIN.gets.strip.downcase
      end until %w[y n].include?(anonymize)

      begin
        log("\u{26a0} \u{26a0} Are you sure you want to DESTROY theirs contributions \u{2049} (y/n)")
        destroy = %w[y n].include?(force) ? force : STDIN.gets.strip.downcase
      end until %w[y n].include?(destroy)

      if anonymize == 'y'
        log("\u{1f4a5} Let's go !")

        progressbar = ProgressBar.create(title: 'Deleting users', total: total_bots, format: '%t |%b%i| %p%% %t')

        bots.find_each(batch_size: 1000) do |user|
          if destroy == 'y'
            Decidim::Report.where(user: user).destroy_all
            Decidim::Comments::CommentVote.where(author: user).destroy_all
            Decidim::Comments::Comment.where(author: user).destroy_all
            Decidim::Messaging::Message.where(sender: user).destroy_all
            Decidim::ActionLog.where(user: user).destroy_all
          end

          Decidim::DestroyAccount.call(
              user,
              Decidim::DeleteAccountForm.from_params(
                  delete_reason: "Bot cleaning of @#{user.nickname} (#{user.id})"
              )
          )

          progressbar.increment
        end
      else
        log("\u{1f937} Sorry for the confusion ...")
      end
    end

    Rails.logger.close
    Rails.logger = Logger.new(STDOUT)
  end
end
