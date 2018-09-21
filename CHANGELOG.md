# Change Log

## 0.12.2 - OSP specific changes:

### Fixes :

- **Button "Modifier la proposition" appears when it shoudn't**  
(https://github.com/OpenSourcePolitics/decidim/issues/241)  
RESTORED [`decidim-core/`] `app/controllers/concerns/decidim/needs_permission.rb`

- **Admin attachment upload size**
(https://github.com/OpenSourcePolitics/decidim/pull/258)  
+(https://github.com/OpenSourcePolitics/decidim/issues/233)  
--> set to 250 Mo
cf. `config/initializers/decidim.rb:13`


## 0.12.1 - OSP specific changes:

### Fixes :

- **Button "Modifier la proposition" appears when it shoudn't**  
(https://github.com/OpenSourcePolitics/decidim/issues/241)  
OVERRIDES [`decidim-core/`] `app/controllers/concerns/decidim/needs_permission.rb`  
:warning: THIS NEED TO BE REVERT WHEN UPGRADING TO 0.12.2+ :white_check_mark:

### Features :

- **General Map (Proposals & Meetings)**  
OVERRIDES [`decidim-core/`] `app/assets/javascripts/decidim/map.js.es6`  
Add a new layer with the IRIS Zone (stored in `app/assets/javascripts/data/mel_communes.geojson.js`)

### Style :

- OVERRIDES in `app/assets/stylesheets/decidim.scss`

### i18n :

- OVERRIDES in `config/locales/fr.yml`
