class Attendance < ActiveRecord::Base
    belongs_to :user
    belongs_to :event
    has_one :feedback
end
