module Admin
  class PatientsController < BaseController
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

      # The page opens on the patient's most recent day of activity — the one
      # an admin actually wants to see — and the date picker moves from there.
      @date = parsed_date || last_activity_on || Date.current
      @meal_logs = @patient.meal_logs.where(eaten_on: @date)
                           .includes(meal_plan_meal: [ :meal_plan_day, { photo_attachment: :blob } ])
                           .order(:id)
      @exercise_logs = @patient.exercise_logs.where(completed_on: @date)
                               .includes(exercise: { thumbnail_attachment: :blob })
                               .order(:id)
      @health_readings = @patient.health_readings.where(recorded_on: @date)
      @daily_goal = @patient.daily_goal_completions.find_by(date: @date)
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

    def parsed_date
      Date.parse(params[:date]) if params[:date].present?
    rescue Date::Error
      nil
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
