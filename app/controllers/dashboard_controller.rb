class DashboardController < ApplicationController
  def index
    @recent_weight_logs = current_user.weight_logs.recent.limit(7)
    @current_weight = current_user.current_weight
    @current_bmi = current_user.current_bmi
    @active_goal = current_user.goals.active.first
    @weight_log = WeightLog.new
    
    # 体重推移グラフ用のデータ
    @weight_chart_data = current_user.weight_logs.order(:date).pluck(:date, :weight).to_h
    
    # 過去30日間のデータがあれば、それを表示
    thirty_days_ago = Date.current - 30.days
    @weight_logs_30days = current_user.weight_logs.where('date >= ?', thirty_days_ago).order(:date)
    
    # 体脂肪率のデータがあれば、それも表示
    @body_fat_chart_data = current_user.weight_logs.where.not(body_fat: nil).order(:date).pluck(:date, :body_fat).to_h
  end
end
