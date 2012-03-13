class User < ActiveRecord::Base
    has_many :attendances
    has_many :events, :through => :attendances

    def update_credentials!(credentials)
      self.token  = credentials.token
      self.secret = credentials.secret
      save!
    end

    def attend!(event)
      self.attendances.create!(:user => self, :event => event)
    end
end
