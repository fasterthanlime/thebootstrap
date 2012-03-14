class FeedbacksController < ApplicationController
  def create
    render :json => params
  end

end
