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
end
