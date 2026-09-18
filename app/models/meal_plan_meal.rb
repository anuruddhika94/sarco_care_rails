class MealPlanMeal < ApplicationRecord
  belongs_to :meal_plan_day, inverse_of: :meal_plan_meals
  has_many :meal_plan_items, -> { order(:position) }, dependent: :destroy, inverse_of: :meal_plan_meal
  has_one_attached :photo

  enum :slot, { breakfast: 0, lunch: 1, dinner: 2, before_bed: 3, snack: 4 }

  validates :title_en, :title_th, :icon, :total_protein_en, :total_protein_th, presence: true

  # `image` is either a bundled Flutter asset path (the seeded plan's
  # photos, e.g. "assets/images/meals/plan_d1_breakfast.jpg") or, once an
  # admin uploads a photo from the dashboard, the URL of that upload —
  # the uploaded file always wins so re-uploading replaces the seeded shot.
  def image
    return Rails.application.routes.url_helpers.rails_blob_url(photo, **Current.blob_url_options) if photo.attached?
    self[:image]
  end

  def serializable_hash(options = nil)
    options ||= {}
    super(options.reverse_merge(
      only: [ :id, :slot, :title_en, :title_th, :icon, :total_protein_en, :total_protein_th, :position ],
      methods: [ :image ],
      include: { meal_plan_items: {} }
    ))
  end
end
