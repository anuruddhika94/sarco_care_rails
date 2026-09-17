# Needed for Active Storage's rails_blob_url (used in User#avatar_url) to
# build an absolute URL — there's no request to infer the host from when
# it's called from a model. Matches the API's own default host/port (see
# ApiClient's API_BASE_URL default in the Flutter app); override with
# APP_HOST/APP_PORT for other setups (e.g. an Android emulator or a real
# device on the LAN).
Rails.application.routes.default_url_options[:host] = ENV.fetch("APP_HOST", "localhost")
Rails.application.routes.default_url_options[:port] = ENV.fetch("APP_PORT", 3000) unless Rails.env.production?
