class EventsController < ApplicationController
  before_filter :mark_admin

  def index
    valid_whens = %w(past upcoming)
    @when = params[:when]
    @when = 'upcoming' if not valid_whens.include? @when

    @events = Event.timeslice(@when)
  end

  def new
  end

  def create
    event = Event.new({
      name: params[:name],
      place: params[:place],
      description: params[:description],
      creator: current_user,
    }) do |e|
      e.occurs_at = Time.iso8601(params[:occurs_at])
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

  def destroy
    id = params[:id]
    event = Event.find(id)
    if event.creator.id == current_user.id || current_user.admin == true
      event.destroy
      redirect_to :root
    else
      redirect_to event
    end
  end

private

  def mark_admin
    @is_admin = is_admin
  end
end
