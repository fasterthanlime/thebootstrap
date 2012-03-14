class Event < ActiveRecord::Base
    has_many :attendances
    has_many :users, :through => :attendances

    has_many :feedbacks
    belongs_to :creator, :class_name => 'User'

    validates :name, :presence => true
    validates :place, :presence => true
    validates :occurs_at, :presence => true
    validates :creator, :presence => true

    def self.upcoming_events
      Event.where("occurs_at >= ?", Time.now).order('occurs_at ASC').all(:limit => 10)
    end

    def self.past_events
      Event.where("occurs_at <= ?", Time.now).order('occurs_at ASC').all(:limit => 10)
    end
end
