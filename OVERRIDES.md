# Decidim overrides

## List of files overriden from external gems

These files needs to check when updating the corresponding gem

### decidim/decidim-admin
* `app/views/decidim/admin/organization_appearance/_form.html.erb`

### decidim/decidim-core
* `app/assets/stylesheets/decidim/email.css`
* `app/helpers/decidim/omniauth_helper.rb`
* `app/uploaders/decidim/attachment_uploader.rb`
* `app/views/decidim/account/show.html.erb`
* `app/views/decidim/authorization_modals/_content.html.erb`
* `app/views/decidim/authorization_modals/show.html.erb`
* `app/views/decidim/devise/omniauth_registrations/new.html.erb`
* `app/views/decidim/devise/sessions/new.html.erb`
* `app/views/decidim/devise/sessions/new.html.erb.bkp`
* `app/views/decidim/devise/shared/_omniauth_buttons_mini.html.erb`
* `app/views/decidim/devise/shared/_omniauth_buttons.html.erb`
* `app/views/decidim/shared/_login_modal.html.erb`
* `app/views/decidim/shared/_login_modal.html.erb.bkp`
* `app/views/devise/mailer/confirmation_instructions.html.erb`
* `app/views/devise/mailer/email_changed.html.erb`
* `app/views/layouts/decidim/_cookie_warning.html.erb`
* `app/views/layouts/decidim/_logo.html.erb`
* `app/views/layouts/decidim/_main_footer.html.erb`
* `app/views/layouts/decidim/_mini_footer.html.erb`
* `app/views/layouts/decidim/_social_media_links.html.erb`
* `app/views/layouts/decidim/_wrapper.html.erb`
* `app/views/layouts/decidim/mailer.html.erb`

### decidim/decidim-initiatives
* `app/helpers/decidim/initiatives/create_initiative_helper.rb`
* `app/helpers/decidim/initiatives/initiative_helper.rb.bkp`
* `app/permissions/decidim/initiatives/permissions.rb`
* `app/views/decidim/initiatives/admin/answers/_info_initiative.html.erb`
* `app/views/decidim/initiatives/admin/initiatives/_form.html.erb`
* `app/views/decidim/initiatives/admin/initiatives/edit.html.erb`
* `app/views/decidim/initiatives/create_initiative/fill_data.html.erb`
* `app/views/decidim/initiatives/create_initiative/previous_form.html.erb`
* `app/views/decidim/initiatives/initiatives/_filters.html.erb`
* `app/views/decidim/initiatives/initiatives_mailer/_initiative_link.html.erb`
* `app/views/decidim/initiatives/initiatives_mailer/notify_creation.html.erb`
* `app/views/decidim/initiatives/initiatives_mailer/notify_progress.html.erb`
* `app/views/decidim/initiatives/initiatives_mailer/notify_state_change.html.erb`
* `app/views/decidim/initiatives/initiatives_mailer/notify_validating_request.html.erb`

### decidim/decidim-pages
* `app/views/decidim/pages/_standalone.html.erb`

### decidim/decidim-verifications
* `app/views/decidim/verifications/authorizations/_granted_authorization.html.erb`
* `app/views/decidim/verifications/authorizations/index.html.erb`
* `app/views/decidim/verifications/metadata/_content.html.erb`
* `app/views/decidim/verifications/metadata/_value.html.erb`

## Extends

These files are not direct overrides but extends of existing classes of the decidim gem.  
They are loaded in the config file `config/initializers/extends.rb`

* `lib/extends/create_omniauth_registration_extend.rb`
* `lib/extends/initiative_admin_form_extend.rb`
* `lib/extends/initiative_model_extend.rb`
* `lib/extends/organization_appearance_form_extend.rb`
* `lib/extends/update_organization_appearance_extend.rb`
