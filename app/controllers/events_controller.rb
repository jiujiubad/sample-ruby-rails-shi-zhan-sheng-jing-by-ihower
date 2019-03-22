class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    if params[:keyword]
      @events = Event.where( [ "name like ?", "%#{params[:keyword]}%"])
    else
      @events = Event.all
    end
    sort_by = (params[:order]=='name')?'name':'created_at'
    @events = @events.order(sort_by).page(params[:page]).per(5)
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

  def lastest
    @events = Event.order("id DESC").limit(3)
  end

  def bulk_delete
    Event.destroy_all
    redirect_to events_url
  end

  def bulk_update
    ids = Array(params[:ids])
    events = ids.map{ |i| Event.find_by_id(i) }.compact
    if params[:commit] == "Publish"
      events.each{ |e| e.update( :status => "published" ) }
    elsif params[:commit] == "Delete"
      events.each{ |e| e.destroy }
    end
    redirect_to events_url
  end

  def dashboard
    @event = Event.find(params[:id])
  end

  def join
    @event = Event.find(params[:id])
    @event.update_attributes(remark: 'Joined')
    redirect_to events_url
  end

  def withdraw
    @event = Event.find(params[:id])
    @event.update_attributes(remark: 'withdraw')
    redirect_to events_url
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :remark, :category_id, :keyword, location_attributes: [:id, :name, :_destroy], group_ids: [])
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
