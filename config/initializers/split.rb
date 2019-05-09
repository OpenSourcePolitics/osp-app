require 'split/dashboard'
include Split::Helper

Split.configure do |config|
  config.allow_multiple_experiments = true
end
