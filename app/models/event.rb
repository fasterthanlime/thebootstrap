class Event < ActiveRecord::Base
    has_many :attendances
    has_many :users, :through => :attendances

    has_many :feedbacks

    def self.top_visible_events
      Event.order('created_at DESC').all(:limit => 10)
    end
end
