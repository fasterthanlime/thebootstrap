class Event < ActiveRecord::Base
    has_many :attendances
    has_many :users, :through => :attendances

    has_many :feedbacks
    belongs_to :creator, :class_name => 'User'

    def self.top_visible_events
      Event.order('created_at DESC').all(:limit => 10)
    end
end
