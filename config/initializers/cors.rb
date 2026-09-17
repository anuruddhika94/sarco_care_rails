# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin Ajax requests.
#
# The Flutter app ships as a mobile app (no browser origin) and a web build
# hosted on GitHub Pages, so we allow that origin plus localhost for the
# Flutter web dev server. Override/extend via CORS_ORIGINS (comma-separated)
# for other deployments.
#
# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    default_origins = [
      "https://anuruddhika94.github.io",
      "http://localhost:*"
    ]
    origins(ENV["CORS_ORIGINS"]&.split(",") || default_origins)

    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
