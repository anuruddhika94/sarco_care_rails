module Admin
  class PatientsController < BaseController
    # Sections the page can refresh on their own (see _date_picker).
    SECTIONS = %w[goals meals exercises health].freeze

    before_action :set_patient, only: [ :show, :edit, :update, :destroy ]

    def index
      @patients = User.patient.with_attached_avatar.order(:full_name)
      if params[:q].present?
        q = "%#{params[:q]}%"
        @patients = @patients.where("full_name ILIKE :q OR phone_number ILIKE :q", q: q)
      end
    end

    def show
      @assessments = @patient.assessments.order(completed_at: :desc).limit(10)
      @caretakers = @patient.approved_caretaker_links.includes(:caretaker)

      @activity_totals = {
        meals: @patient.meal_logs.count,
        exercises: @patient.exercise_logs.count,
        minutes: @patient.exercise_logs.sum(:minutes),
        last_seen: last_activity_on
      }

      # Every section opens on today and moves independently, so an admin can
      # line up, say, a meal on one day against a weight taken on another.
      # "Last activity" in the summary above says where to look if today is
      # empty.
      @meal_date = date_param(:meal_date)
      @exercise_date = date_param(:exercise_date)
      @health_date = date_param(:health_date)
      @goal_date = date_param(:goal_date)

      @meal_logs = @patient.meal_logs.where(eaten_on: @meal_date)
                           .includes(meal_plan_meal: [ :meal_plan_day, { photo_attachment: :blob } ])
                           .order(:id)
      @exercise_logs = @patient.exercise_logs.where(completed_on: @exercise_date)
                               .includes(exercise: { thumbnail_attachment: :blob })
                               .order(:id)
      @health_readings = @patient.health_readings.where(recorded_on: @health_date)
      @daily_goal = @patient.daily_goal_completions.find_by(date: @goal_date)

      # The page's date pickers fetch just their own section and swap it in,
      # so changing a day doesn't reload everything.
      return unless SECTIONS.include?(params[:section])

      render partial: "admin/patients/#{params[:section]}_section", layout: false
    end

    def edit
    end

    def update
      if @patient.update(patient_params)
        redirect_to admin_patient_path(@patient), notice: "Profile updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @patient.destroy!
      redirect_to admin_patients_path, notice: "#{@patient.full_name} was removed."
    end

    private

    # A date from the query string, defaulting to today. Ignores anything
    # unparseable rather than blowing up on a hand-edited URL.
    def date_param(key)
      value = params[key]
      return Date.current if value.blank?

      Date.parse(value)
    rescue Date::Error
      Date.current
    end

    # The most recent day this patient did anything at all.
    def last_activity_on
      @last_activity_on ||= [ @patient.meal_logs.maximum(:eaten_on),
                              @patient.exercise_logs.maximum(:completed_on),
                              @patient.health_readings.maximum(:recorded_on) ].compact.max
    end

    def set_patient
      @patient = User.patient.find(params[:id])
    end

    def patient_params
      permitted = params.expect(user: [ :full_name, :email, :phone_number, :gender, :date_of_birth, :password ])
      # A blank password means "keep the current one".
      permitted.delete(:password) if permitted[:password].blank?
      permitted
    end
  end
end
