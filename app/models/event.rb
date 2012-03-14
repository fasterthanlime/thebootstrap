class Event < ActiveRecord::Base
    has_many :attendances
    has_many :users, :through => :attendances

    has_many :feedbacks
    belongs_to :creator, :class_name => 'User'

    def self.upcoming_events
      Event.where("occurs_at >= ?", Time.now.to_date).order('occurs_at ASC').all(:limit => 10)
    end
end
