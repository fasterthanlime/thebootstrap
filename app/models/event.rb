class Event < ActiveRecord::Base
    has_many :attendances
    has_many :users, :through => :attendances

    has_many :feedbacks
    belongs_to :creator, :class_name => 'User'

    validates :name, :presence => true
    validates :place, :presence => true
    validates :occurs_at, :presence => true
    validates :creator, :presence => true

    def self.timeslice(period, offset = 0, limit = 10)
        Event.where("occurs_at #{operator period} ?", Time.now) \
            .order('occurs_at ASC').all(:offset => offset, :limit => 10)
    end

    def self.timeslice_count(period)
        Event.where("occurs_at #{operator period} ?", Time.now).count
    end

    private

    def self.operator(period)
        if period == 'upcoming'
            '>='
        else
            '<='
        end
    end
end
