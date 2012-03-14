class FeedbacksController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    Feedback.create({
      event: event,
      user: current_user,
      content: params[:content],
      url: params[:url]
    })

    redirect_to event
  end

  def destroy
    feedback = Feedback.find(params[:id])
    if feedback.user.id == current_user.id || current_user.admin == true
      feedback.destroy
    end
    
    redirect_to feedback.event
  end

end
