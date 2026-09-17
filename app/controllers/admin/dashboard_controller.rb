module Admin
  class DashboardController < BaseController
    def show
      @patient_count = User.patient.count
      @caretaker_count = User.caretaker.count
      @pending_links_count = CareLink.pending.count
      @recent_patients = User.patient.order(created_at: :desc).limit(5)
      @recent_caretakers = User.caretaker.order(created_at: :desc).limit(5)
    end
  end
end
