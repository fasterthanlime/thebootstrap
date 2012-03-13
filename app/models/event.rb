class Event < ActiveRecord::Base
    has_many :users, :through => :attendances

    def top_visible_events
      Event.all(:limit => 10)
    end
end
