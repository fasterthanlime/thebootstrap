class EventsController < ApplicationController
  before_filter :mark_admin

  def index
    @events = Event.top_visible_events
  end

  def new
    if not is_admin
      redirect_to '/events'
      return
    end
  end

  def create
    event = Event.create({
      name: params[:name],
      place: params[:place],
      description: params[:description],
    }) do |e|
      e.occurs_at = params[:occurs_at]
    end
    current_user.attend!(event)

    redirect_to event
  end

  def show
    id = params[:id]
    @event = Event.find(id)
  end

private

  def mark_admin
    @is_admin = is_admin
  end
end
