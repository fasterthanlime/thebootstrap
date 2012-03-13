class EventsController < ApplicationController
  def index
    @events = Event.top_visible_events
  end

  def show
  end

end
