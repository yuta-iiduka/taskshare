class EventsController < ApplicationController
  def index
    @targeturl = params[:targeturl]
    @targetyear = params[:targetyear]
    @targetmonth = params[:targetmonth]
    @targetday = params[:targetday]
    @events = current_user.events
    @event = Event.new
    @event.user_id = current_user.id
  end
  
  def create
    event = Event.create(event_params)
    event.user_id = current_user.id
    event.save
    redirect_to user_events_path
  end
  
  def show
    @events = current_user.events
    @event = Event.find(params[:id])
  end
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to user_events_path(current_user)
  end
  
  def edit
    @event = Event.find(params[:id])
  end
  
  private
  
  def event_params
    params.require(:event).permit(:title, :content, :start_time , :end_time , :tasklink)
  end
end
