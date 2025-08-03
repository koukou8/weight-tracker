class WeightLog < ApplicationRecord
  belongs_to :user

  validates :date, presence: true, uniqueness: { scope: :user_id }
  validates :weight, presence: true, numericality: { greater_than: 0 }
  validates :body_fat, numericality: { greater_than: 0, less_than: 100 }, allow_blank: true

  scope :recent, -> { order(date: :desc) }
  scope :by_date_range, ->(start_date, end_date) { where(date: start_date..end_date) }

  def bmi
    return nil unless user&.height
    (weight / (user.height / 100.0) ** 2).round(1)
  end
end
