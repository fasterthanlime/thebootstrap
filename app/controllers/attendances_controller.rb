class AttendancesController < ApplicationController

  def create
    event = Event.find(params[:event_id])
    current_user.attend!(event)

    redirect_to event
  end

end
