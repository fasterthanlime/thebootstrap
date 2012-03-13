CREDENTIALS = YAML.load_file("#{Rails.root}/config/credentials.yml")[Rails.env].symbolize_keys

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, CREDENTIALS[:twitter_key], CREDENTIALS[:twitter_secret]
end
