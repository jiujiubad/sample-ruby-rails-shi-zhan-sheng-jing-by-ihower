class EventLocationsController < ApplicationController
  before_action :find_event

  def show
    @location = @event.location
  end

  def new
    @location = @event.build_location
  end

  def create
    @location = @event.build_location(location_params)
    if @location.save
      redirect_to event_location_url(@event)
    else
      render :new
    end
  end

  def edit
    @location = @event.location
  end

  def update
    @location = @event.location
    if @location.update(location_params)
      redirect_to event_location_url(@event)
    else
      render :edit
    end
  end

  def destroy
    @location = @event.location
    @location.destroy
    redirect_to event_location_url(@event)
  end

  private

  def location_params
    params.require(:location).permit(:name)
  end

  def find_event
    @event = Event.find(params[:event_id])
  end
end
