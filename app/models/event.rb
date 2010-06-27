# -*- coding: utf-8 -*-
class Event < ActiveRecord::Base
  named_scope :front_collection, :order => 'date', :limit => 5, :conditions => ["date > ?", Time.now]
  named_scope :in_future, :order => 'date', :conditions => ["date > ?", Time.now]

  def initialize *args
    super( *args )
    self.date = Time.now + 1.day
  end

  def self.next event
    event = Event.find( event ) if event.is_a? Fixnum
    Event.find( :first, :conditions => { :date_gt => event.date } ) || Event.create( :artist => 'unknown', :date => Time.now )
  end

  def self.prev event
    event = Event.find( event ) if event.is_a? Fixnum
    logger.debug "Event:" + Event.find( :first, :conditions => { :date_lt => event.date } ).inspect
    Event.find( :last, :conditions => { :date_lt => event.date } ) || Event.in_future.last
  end

  def ready?
    # TODO: Приделать сюда нормальную проверку. ( Все поля должны быть заполнены )
    true
  end

  def vip? 
    false
  end

  def indicator
    if vip?
      "vip"
    elsif date.today?
      "today"
    else
      "main"
    end
  end
end
