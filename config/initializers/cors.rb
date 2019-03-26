# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "#{ENV['APP_PROTOCOL']}://#{ENV['APP_HOST']}:#{ENV['APP_PORT']}"

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
    
    resource '/api/*',
      headers: %w(Authorization),
      methods: [:get, :post, :put, :patch, :delete],
      expose: %w(Authorization),
      max_age: 600
  end
end
