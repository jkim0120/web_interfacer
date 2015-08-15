class StatsController < ApplicationController
  before_action :require_tracker_authenticated, only: :new

  def new
    @stat = Stat.new

    respond_to do |format|
      format.html { render layout: !request.xhr? }
    end
  end

  def create
    @stat = Stat.new(stat_params)

    respond_to do |format|
      if @stat.save
        format.html { redirect_to user_stat_path(current_user, @stat) }
        format.js {}
      else
        format.html { render :new }
        format.js {}
      end
    end
  end

  def show
    @stat = Stat.find(params[:id])
  end

  private
  def stat_params
    params.require(:stat).require(:average_time, :accuracy)
  end
end
