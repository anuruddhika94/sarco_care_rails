class Article < ApplicationRecord
  enum :category, { general: 0, food: 1, exercise: 2, prevention: 3 }

  validates :title_en, :title_th, :summary_en, :summary_th, :icon, presence: true

  default_scope { order(:position) }

  def serializable_hash(options = nil)
    options ||= {}
    super(options.reverse_merge(
      only: [:id, :category, :icon, :title_en, :title_th, :summary_en, :summary_th, :body_en, :body_th, :read_minutes]
    ))
  end
end
