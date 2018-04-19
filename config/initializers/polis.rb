
Rails.application.config.polis = YAML.load_file("#{Rails.root.to_s}/config/polis.yml")[Rails.env]
