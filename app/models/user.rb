class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :weight_logs, dependent: :destroy
  has_many :goals, dependent: :destroy

  validates :name, presence: true
  validates :height, presence: true, numericality: { greater_than: 0 }
  validates :gender, presence: true, inclusion: { in: %w[male female other] }
  validates :target_weight, numericality: { greater_than: 0 }, allow_blank: true

  def current_bmi
    return nil unless height && weight_logs.any?
    current_weight = weight_logs.order(:date).last.weight
    (current_weight / (height / 100.0) ** 2).round(1)
  end

  def current_weight
    weight_logs.order(:date).last&.weight
  end
end
