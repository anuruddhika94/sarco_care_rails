class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar

  enum :role, { patient: 0, caretaker: 1 }
  enum :gender, { male: 0, female: 1, other: 2 }, prefix: true

  # Care links where this user is the patient / the caretaker.
  has_many :patient_care_links, class_name: "CareLink", foreign_key: :patient_id, dependent: :destroy, inverse_of: :patient
  has_many :caretaker_care_links, class_name: "CareLink", foreign_key: :caretaker_id, dependent: :destroy, inverse_of: :caretaker

  has_many :approved_caretaker_links, -> { approved }, class_name: "CareLink", foreign_key: :patient_id, inverse_of: :patient
  has_many :caretakers, through: :approved_caretaker_links, source: :caretaker

  has_many :approved_patient_links, -> { approved }, class_name: "CareLink", foreign_key: :caretaker_id, inverse_of: :caretaker
  has_many :patients, through: :approved_patient_links, source: :patient

  has_many :health_readings, foreign_key: :patient_id, dependent: :destroy, inverse_of: :patient
  has_many :assessments, foreign_key: :patient_id, dependent: :destroy, inverse_of: :patient
  has_many :exercise_logs, foreign_key: :patient_id, dependent: :destroy, inverse_of: :patient
  has_many :meal_logs, foreign_key: :patient_id, dependent: :destroy, inverse_of: :patient
  has_many :reminders, foreign_key: :patient_id, dependent: :destroy, inverse_of: :patient
  has_many :daily_goal_completions, foreign_key: :patient_id, dependent: :destroy, inverse_of: :patient

  validates :full_name, presence: true
  validates :phone_number, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }, allow_nil: true

  after_create :assign_default_reminders, if: :patient?

  DEFAULT_REMINDERS = [
    { kind: :breakfast, time_of_day: "07:00", enabled: true },
    { kind: :lunch, time_of_day: "12:00", enabled: true },
    { kind: :dinner, time_of_day: "18:30", enabled: true },
    { kind: :water, time_of_day: nil, enabled: true },
    { kind: :exercise, time_of_day: "17:00", enabled: false },
    { kind: :medication, time_of_day: "09:00", enabled: true },
    { kind: :sleep, time_of_day: "22:00", enabled: true }
  ].freeze

  # Every patient starts with the standard reminder toggles, so Notifications
  # isn't empty the moment an account is created. The exercise/meal catalogs
  # are shared across all patients (see Exercise, MealPlanDay); only what a
  # patient actually did (ExerciseLog/MealLog) is per-patient.
  def assign_default_reminders
    DEFAULT_REMINDERS.each do |data|
      reminders.find_or_create_by!(kind: data[:kind]) do |r|
        r.time_of_day = data[:time_of_day]
        r.enabled = data[:enabled]
      end
    end
  end

  def age
    return nil unless date_of_birth

    ((Date.current - date_of_birth) / 365.25).floor
  end

  def avatar_url
    return nil unless avatar.attached?
    Rails.application.routes.url_helpers.rails_blob_url(avatar)
  end

  def serializable_hash(options = nil)
    options ||= {}
    super(options.reverse_merge(
      only: [ :id, :full_name, :phone_number, :email, :role, :date_of_birth, :gender, :settings ],
      methods: [ :age, :avatar_url ]
    ))
  end
end
