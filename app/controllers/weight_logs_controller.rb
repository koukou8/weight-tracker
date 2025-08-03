class WeightLogsController < ApplicationController
  before_action :set_weight_log, only: [:show, :edit, :update, :destroy]

  def index
    @weight_logs = current_user.weight_logs.recent.includes(:user)
    @weight_logs = @weight_logs.by_date_range(params[:start_date], params[:end_date]) if params[:start_date] && params[:end_date]
  end

  def show
  end

  def new
    @weight_log = current_user.weight_logs.build
  end

  def create
    @weight_log = current_user.weight_logs.build(weight_log_params)
    
    if @weight_log.save
      redirect_to weight_logs_path, notice: '体重記録を作成しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @weight_log.update(weight_log_params)
      redirect_to @weight_log, notice: '体重記録を更新しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @weight_log.destroy
    redirect_to weight_logs_path, notice: '体重記録を削除しました。'
  end

  private

  def set_weight_log
    @weight_log = current_user.weight_logs.find(params[:id])
  end

  def weight_log_params
    params.require(:weight_log).permit(:date, :weight, :body_fat, :memo)
  end
end
