# frozen_string_literal: true

# Critical tasks, DO NOT USE in production
# Allows to manipulate data from DB
namespace :critical do
  Rails.logger = Logger.new(STDOUT)

  desc "Destroy account using destroy_account decidim's command"
  task destroy_accounts: :environment do
    # TODO: Force params insertion in rake task to avoid command by mistake
    #
    begin
      exit(2) unless prompt("destroy_accounts is a critical command, please confirm your choice ? [y/n] ") == "y"
    rescue SystemExit => e
      puts "Choice not confirmed : Exit status #{ e.status }"
    else
      puts "\nRake task exited successfully !"
    end
    Rails.logger.close
  end

end

# Returns user input from STDIN
def prompt(*args)
  print(*args)
  STDIN.gets.chomp
end
