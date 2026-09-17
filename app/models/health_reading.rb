class HealthReading < ApplicationRecord
  belongs_to :patient, class_name: "User", inverse_of: :health_readings

  validates :recorded_on, presence: true

  def bmi
    return nil if weight_kg.blank? || height_cm.blank? || height_cm.to_f.zero?

    height_m = height_cm.to_f / 100.0
    (weight_kg.to_f / (height_m * height_m)).round(1)
  end

  def serializable_hash(options = nil)
    options ||= {}
    super(options.reverse_merge(
      only: [:id, :recorded_on, :weight_kg, :height_cm, :calf_cm],
      methods: [:bmi]
    ))
  end
end
