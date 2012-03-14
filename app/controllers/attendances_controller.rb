class AttendancesController < ApplicationController

  def create
    event = Event.find(params[:event_id])
    current_user.attend!(event)

    redirect_to event
  end

  def destroy
    attendance = Attendance.find(params[:id])
    attendance.destroy

    redirect_to attendance.event
  end

end
