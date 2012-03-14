class EventsController < ApplicationController
  before_filter :mark_admin

  def index
    @events = Event.upcoming_events
  end

  def new
    if not is_admin
      redirect_to '/events'
      return
    end
  end

  def create
    event = Event.new({
      name: params[:name],
      place: params[:place],
      description: params[:description],
      creator: current_user,
    }) do |e|
      e.occurs_at = params[:occurs_at]
    end
    valid = event.save
    
    if valid
      current_user.attend!(event)
      redirect_to event
    else
      flash[:error] = 'Invalid data! Try again to create the event'
      redirect_to '/events/new'
    end
  end

  def show
    id = params[:id]
    if Event.exists?(id)
      @event = Event.find(id)
    else
      redirect_to :root
    end
  end

private

  def mark_admin
    @is_admin = is_admin
  end
end
