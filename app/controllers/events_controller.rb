# -*- coding: utf-8 -*-
class EventsController < ApplicationController
  filter_access_to :all

  # GET /events
  # GET /events.xml
  def index
    @events = Event.in_future
    @event = @events.last || Event.new

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
      format.js
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])

    @event.date ||= Time.now
    @event.artist ||= ''
    @event.title ||= ''
    @event.text ||= ''
    @event.city ||= 'Москва'
    @event.price ||= 0.0

    respond_to do |format|
      if @event.save
        flash[:notice] = 'Event was successfully created.'
        format.html { redirect_to(@event) }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
        format.js   { render :action => "show", :id => @event.id }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])

        @event = case params[:submit_button]
                 when "fwd" then
                   Event.next @event
                 when "prev" then
                   Event.prev @event
                 else
                   @event
                 end
        
        flash[:notice] = 'Event was successfully updated.'
        format.html { redirect_to(@event) }
        format.xml  { head :ok }
        format.js   { render :action => "show", :id => @event.id, :update_list => true }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  rescue ActiveRecord::RecordNotFound
    @event = Event.in_future.first || @event.new
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event_to_kill = Event.find(params[:id])
    @event = Event.prev(@event_to_kill)

    @event = Event.new if @event_to_kill == @event

    @event_to_kill.destroy


    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
      format.js   { render :action => "show", :id => @event.id }
    end
  rescue ActiveRecord::RecordNotFound
    @event = Event.in_future.first || @event.new
  end
end
