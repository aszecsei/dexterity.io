Rails.application.config.middleware.use OmniAuth::Builder do
    provider :github, 'e45eb735c8132bfa2d08', '2edb3211ea43cb470f246b7114f702a3bec900a6'
end