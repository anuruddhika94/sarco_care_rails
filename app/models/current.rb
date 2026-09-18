# Per-request host/port/protocol, set from ApplicationController so model
# methods that build absolute URLs (User#avatar_url, MealPlanMeal#image) can
# mirror back whatever host the client actually used to reach the API —
# critical on mobile, where that might be localhost (iOS Simulator), an
# Android emulator's 10.0.2.2, or a LAN IP for a physical device. A
# hardcoded host would be unreachable from whichever of those the client
# isn't running from.
class Current < ActiveSupport::CurrentAttributes
  attribute :request_host, :request_port, :request_protocol

  # Falls back to the APP_HOST/APP_PORT defaults (see the
  # default_url_options initializer) when there's no current request, e.g.
  # a rake task or the Rails console.
  def self.blob_url_options
    {
      host: request_host || ENV.fetch("APP_HOST", "localhost"),
      port: (request_port || ENV.fetch("APP_PORT", 3000)).to_i,
      protocol: request_protocol || "http://"
    }
  end
end
