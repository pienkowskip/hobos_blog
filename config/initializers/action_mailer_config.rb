mailer_config = YAML.load_file("#{Rails.root.to_s}/config/mailer.yml").fetch(Rails.env.to_s)
mailer_config.deep_symbolize_keys!
mailer_config.each do |key, value|
  Rails.application.config.action_mailer[key] = value
end
