class User < ActiveRecord::Base
    has_many :events, :through => :attendances

    def update_credentials!(credentials)
      self.token  = credentials.token
      self.secret = credentials.secret
      save!
    end
end
