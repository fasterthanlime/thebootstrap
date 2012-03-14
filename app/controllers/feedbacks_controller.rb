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

end
