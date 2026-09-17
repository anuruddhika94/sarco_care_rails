class Exercise < ApplicationRecord
  has_many :exercise_logs, dependent: :destroy

  validates :key, presence: true, uniqueness: true
  validates :name_en, :name_th, :icon, :default_minutes, presence: true

  def serializable_hash(options = nil)
    options ||= {}
    super(options.reverse_merge(
      only: [:id, :key, :name_en, :name_th, :video_id, :icon, :default_minutes, :instructions]
    ))
  end
end
