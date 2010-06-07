# -*- coding: utf-8 -*-
class Event < ActiveRecord::Base
  default_scope :order => "created_at DESC"
  named_scope :front_collection, :order => 'date DESC', :limit => 5

  def self.next event
    event = Event.find( event ) if event.is_a? Fixnum
    Event.find( :first, :conditions => { :created_at_gt => event.created_at } ) || Event.create( :artist => 'unknown', :date => Time.now )
  end

  def self.prev event
    event = Event.find( event ) if event.is_a? Fixnum
    Event.find( :first, :conditions => { :created_at_lt => event.created_at } ) || Event.last
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
