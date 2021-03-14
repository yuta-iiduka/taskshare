class EventsController < ApplicationController
  def index
    @targeturl = params[:targeturl]
    @targetyear = params[:targetyear]
    @targetmonth = params[:targetmonth]
    @targetday = params[:targetday]
    @event = Event.new
    @event.user_id = current_user.id
    @tag_id = params[:tag_id]
    if @tag_id.to_i > 0 
      @tag = Tag.find(@tag_id)
      @events = @tag.events.all
    else
      @events = current_user.events
    end
    @tags = []
    @events.each do |event|
      event.tags.each do |tag|
        @tags.push(tag)
      end
    end
    @tag_all = @tags.uniq #重複を取り除く
  end
  
  def create
    event = Event.create(event_params)
    event.user_id = current_user.id
    tag_list = params[:event][:name].split(",")
    event.save
    event.save_tag(tag_list)
    redirect_to user_events_path(user_id: current_user.id,targeturl: "" ,targetyear: Date.today.year, targetmonth: Date.today.month, targetday: Date.today.day)
  end
  
  def show
    @tag_id = params[:tag_id]
    if @tag_id.to_i > 0 
      @tag = Tag.find(@tag_id)
      @events = @tag.events.all
    else
      @events = current_user.events
    end
    @event = Event.find(params[:id])
    @week_total = {}
    @day_total = {}
  end
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to user_events_path(user_id: current_user.id,targeturl: "" ,targetyear: Date.today.year, targetmonth: Date.today.month, targetday: Date.today.day)
  end
  
  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @events_all = @tag.events.all
  end
  
  
  def edit
    @event = Event.find(params[:id])
  end
  
  private
  
  def event_params
    params.require(:event).permit(:title, :content, :start_time , :end_time , :tasklink)
  end
end
