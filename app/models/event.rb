class Event < ActiveRecord::Base
  named_scope :front_collection, :order => 'date DESC', :limit => 5
end
