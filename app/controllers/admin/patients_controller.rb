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
      @health_readings = @patient.health_readings.order(recorded_on: :desc).limit(10)
      @assessments = @patient.assessments.order(completed_at: :desc).limit(10)
      @caretakers = @patient.approved_caretaker_links.includes(:caretaker)
      @meal_logs = @patient.meal_logs
                           .includes(meal_plan_meal: [ :meal_plan_day, { photo_attachment: :blob } ])
                           .order(eaten_on: :desc, id: :desc).limit(15)
      @exercise_logs = @patient.exercise_logs
                               .includes(exercise: { thumbnail_attachment: :blob })
                               .order(completed_on: :desc, id: :desc).limit(15)
      @daily_goals = @patient.daily_goal_completions.order(date: :desc).limit(7)
      @activity_totals = {
        meals: @patient.meal_logs.count,
        exercises: @patient.exercise_logs.count,
        minutes: @patient.exercise_logs.sum(:minutes),
        last_seen: [ @patient.meal_logs.maximum(:eaten_on),
                     @patient.exercise_logs.maximum(:completed_on),
                     @patient.health_readings.maximum(:recorded_on) ].compact.max
      }
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
