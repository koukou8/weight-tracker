class Goal < ApplicationRecord
  belongs_to :user

  validates :target_weight, presence: true, numericality: { greater_than: 0 }
  validates :target_date, presence: true

  validate :target_date_in_future

  scope :active, -> { where('target_date >= ?', Date.current) }
  scope :recent, -> { order(created_at: :desc) }

  def progress_percentage
    return 0 unless user.current_weight && user.weight_logs.any?
    
    initial_weight = user.weight_logs.order(:date).first.weight
    current_weight = user.current_weight
    
    return 100 if current_weight == target_weight
    
    total_difference = (initial_weight - target_weight).abs
    current_difference = (initial_weight - current_weight).abs
    
    ((current_difference / total_difference) * 100).round(1)
  end

  def days_remaining
    return 0 if target_date < Date.current
    (target_date - Date.current).to_i
  end

  private

  def target_date_in_future
    return unless target_date
    errors.add(:target_date, "must be in the future") if target_date <= Date.current
  end
end
