class MissionsController < ApplicationController
  before_action :set_mission, only: [:review, :complete, :cancel]

  def create
    @mission = Mission.new(mission_params)
    @place = Place.find(params[:place_id])
    @mission.place = @place
    @mission.captaingreen = current_user

    if @mission.save
      redirect_to profile_path
    else
      render 'places/show'
    end
  end

  def cancel
    @mission.status = "cancelled"
    @mission.save

  def review
  end

  def complete
    @mission.update(mission_update_params)
    redirect_to profile_path
  end

  private

  def set_mission
    @mission = Mission.find(params[:id])
  end

  def mission_params
    params.require(:mission).permit(:date, :time_slot, :status)
  end

  def mission_update_params
    params.require(:mission).permit(:mapmaster_photo, :participation_level, :participation_proof)
  end
end
