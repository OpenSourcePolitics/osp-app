# OSP App

Citizen Participation and Open Government application.

This is a base app for all OSP projects. It uses OSP's decidim version.

## Deploying the application

1. `bundle install`
2. `bundle exec rails db:setup`  
_by default seed data are generated on DB setup_
3. `bundle exec rails s`
4. Connect with one of these 2 accounts :
  - admin@example.org / decidim123456
  - user@example.org / decidim123456

## Deploying the application without seed data

1. `bundle install`
2. `bundle exec rails db:create db:schema:load db:migrate`

You will need to do some steps before having the app working properly once you've deployed it:

3. Open a Rails console in the server: `bundle exec rails console`
4. Create a System Admin user:
```ruby
user = Decidim::System::Admin.new(email: <email>, password: <password>, password_confirmation: <password>)
user.save!
```
5. Visit `<your app url>/system` and login with your system admin credentials
6. Create a new organization. Check the locales you want to use for that organization, and select a default locale.
7. Set the correct default host for the organization, otherwise the app will not work properly. Note that you need to include any subdomain you might be using.
8. Fill the rest of the form and submit it.

You're good to go!

## Other configurations

### SMTP settings
* Configurable for each organization via `<your app url>/system`  
* In `development` mode, your app will use `Letter Opener`.  
  Emails can be accessed at `<your app url>/letter_opener`

### Omniauth settings

* Configurable for each organization via `<your app url>/system`  
* Available config keys are the same as the one present in
`config/secrets.yml` and `config/initializers/omniauth.rb`

## Use production data for staging

> !! When working with production data for testing or development, always use the `development` mode (Letter Opener) or blank SMTP settings to prevent sending emails to real imported users !!

1. Import a DB dump on your machine
2. Copy the `secret_key_base` associated with the DB dump in the `config/secrets.yml` file (`development` or `production` part depending on your need)
2. Open a Rails console in the server: `bundle exec rails console`
3. Create a System Admin user:
```ruby
user = Decidim::System::Admin.new(email: <email>, password: <password>, password_confirmation: <password>)
user.save!
```
4. Launch the app i n `development` mode (default) --> `bundle exec rails s`
4. Visit `<your app url>/system` and login with your system admin credentials
5. Edit the organization your want to access with the correct host of your machine (like `localhost`)

## Customizations

### Overrides
see [OVERRIDES.md](./OVERRIDES.md)

### Jobs
These jobs (Active Job) were added on top on the usual Decidim jobs.

* `app/jobs/calculate_all_metrics_job.rb`
* `app/jobs/check_published_initiatives.rb`
* `app/jobs/check_validating_initiatives.rb`
* `app/jobs/clean_sessions.rb`
* `app/jobs/notify_progress_initiatives.rb`
* `app/jobs/preload_open_data.rb`

### Additional tasks

* `lib/tasks/decidim_initiatives_extras.rake`
* `lib/tasks/get_person.rake`
* `lib/tasks/scopes.rake`
