class User < ApplicationRecord
  has_secure_password

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
  has_many :patient_exercise_plans, foreign_key: :patient_id, dependent: :destroy, inverse_of: :patient
  has_many :exercise_logs, foreign_key: :patient_id, dependent: :destroy, inverse_of: :patient
  has_many :reminders, foreign_key: :patient_id, dependent: :destroy, inverse_of: :patient
  has_many :daily_goal_completions, foreign_key: :patient_id, dependent: :destroy, inverse_of: :patient

  validates :full_name, presence: true
  validates :phone_number, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }, allow_nil: true

  def age
    return nil unless date_of_birth

    ((Date.current - date_of_birth) / 365.25).floor
  end

  def serializable_hash(options = nil)
    options ||= {}
    super(options.reverse_merge(
      only: [:id, :full_name, :phone_number, :email, :role, :date_of_birth, :gender, :avatar_url, :settings],
      methods: [:age]
    ))
  end
end
