class Exercise < ApplicationRecord
  has_many :exercise_logs, dependent: :destroy
  has_one_attached :thumbnail

  validates :key, presence: true, uniqueness: true
  validates :name_en, :name_th, :icon, :default_minutes, presence: true

  # The picture the app shows for this exercise: an admin's upload when there
  # is one, otherwise YouTube's own still for the video. Resolved here so the
  # app just renders whatever URL it's given.
  def thumbnail_url
    if thumbnail.attached?
      return Rails.application.routes.url_helpers.rails_blob_url(thumbnail, **Current.blob_url_options)
    end
    return nil if video_id.blank?
    "https://img.youtube.com/vi/#{video_id}/mqdefault.jpg"
  end

  def serializable_hash(options = nil)
    options ||= {}
    super(options.reverse_merge(
      only: [:id, :key, :name_en, :name_th, :video_id, :icon, :default_minutes, :instructions],
      methods: [:thumbnail_url]
    ))
  end
end
