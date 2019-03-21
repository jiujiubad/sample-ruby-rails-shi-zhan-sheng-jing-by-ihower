class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.page(params[:page]).per(5)
    respond_to do |format|
      format.html {@events}
      format.xml {render xml: @events.to_xml}
      format.json {render json: @events.to_json}
      format.atom {render atom: @feed_title = "My event list"}
    end
  end

  def show
    respond_to do |format|
      format.html {@page_title = @event.name}
      format.xml
      format.json {render json: {id: @event.id, name: @event.name}.to_json}
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = "event was successfully created"
      redirect_to events_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      flash[:notice] = "event was successfully updateed"
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    flash[:notice] = "event was successfully deleted"
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :remark)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
