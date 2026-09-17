class Assessment < ApplicationRecord
  belongs_to :patient, class_name: "User", inverse_of: :assessments

  QUESTION_COUNT = 5
  MAX_SEVERITY = 3 # 0 = no problem .. 3 = severe problem, per question

  validates :answers, length: { is: QUESTION_COUNT }
  validate :answers_are_valid_severities

  before_validation :compute_score

  # Mirrors sarco_care/lib/screens/results_screen.dart's _RiskLevel thresholds.
  def risk_level
    return "low" if score <= 3
    return "moderate" if score <= 7

    "high"
  end

  def serializable_hash(options = nil)
    options ||= {}
    super(options.reverse_merge(
      only: [:id, :answers, :score, :completed_at],
      methods: [:risk_level]
    ))
  end

  private

  def compute_score
    self.score = Array(answers).sum.to_i if answers.present?
  end

  def answers_are_valid_severities
    return if answers.blank?

    unless answers.all? { |a| a.is_a?(Integer) && a.between?(0, MAX_SEVERITY) }
      errors.add(:answers, "must be #{QUESTION_COUNT} integers between 0 and #{MAX_SEVERITY}")
    end
  end
end
