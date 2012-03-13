class EventsController < ApplicationController
  def index
    @events = Event.top_visible_events
  end

  def show
    id = params[:id]
    @event = Event.find(id)
  end

end
