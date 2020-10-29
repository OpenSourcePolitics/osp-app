# Decidim overrides

## List of files overriden from external gems

These files needs to check when updating the corresponding gem

### decidim/decidim-admin
* `app/views/decidim/admin/officializations/index.html.erb`
* `app/views/layouts/decidim/admin/_template_bottom.html.erb`
* `app/views/layouts/decidim/admin/settings.html.erb`

### decidim/decidim-core
* `app/cells/decidim/author/profile_inline.erb`
* `app/helpers/decidim/badge_helper.rb`
* `app/views/decidim/devise/sessions/new.html.erb`
* `app/views/decidim/devise/shared/_omniauth_buttons_mini.html.erb`
* `app/views/decidim/devise/shared/_omniauth_buttons.html.erb`
* `app/views/decidim/shared/_login_modal.html.erb`
* `app/views/layouts/decidim/_application.html.erb`
* `app/views/layouts/decidim/_head_extra.html.erb`
* `app/views/layouts/decidim/_social_media_links.html.erb`
* `app/views/layouts/decidim/_wrapper.html.erb`

## Extends

These files are not direct overrides but extends of existing classes of the decidim gem.  
They are loaded in the config file `config/initializers/extends.rb`

* `lib/extends/cells/decidim/author_cell_extend.rb`
* `lib/extends/models/decidim/user_extend.rb`
* `lib/extends/presenters/decidim/proposals/official_author_presenter_extend.rb`
* `lib/extends/presenters/decidim/user_presenter_extend.rb`
