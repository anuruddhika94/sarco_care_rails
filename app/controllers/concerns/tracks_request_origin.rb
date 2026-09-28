# Records the host/port/scheme of the current request so model methods that
# build absolute URLs (User#avatar_url, MealPlanMeal#image, Exercise#thumbnail_url)
# point back at whatever host the client actually used.
#
# Both controller trees need this: the API (ActionController::API) and the
# admin dashboard (ActionController::Base). Without it the fallback host is
# localhost:3000, which renders as a broken image everywhere but a developer's
# own machine.
module TracksRequestOrigin
  extend ActiveSupport::Concern

  included do
    before_action :set_current_request_details
  end

  private

  def set_current_request_details
    Current.request_host = request.host
    Current.request_port = request.port
    Current.request_protocol = request.protocol
  end
end
