class User < ActiveRecord::Base
    has_many :events, :through => :attendances
end
