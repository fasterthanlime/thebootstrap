class User < ActiveRecord::Base
    has_many :events, :through => :attendances

    def update_credentials!(credentials)
      token  = credentials.token
      secret = credentials.secret
      save!
    end
end
