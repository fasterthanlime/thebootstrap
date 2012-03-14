class User < ActiveRecord::Base
    has_many :attendances
    has_many :events, :through => :attendances

    has_many :feedback, :through => :events

    def update_credentials!(credentials)
      self.token  = credentials.token
      self.secret = credentials.secret
      save!
    end

    def attend!(event)
      self.attendances.create!(:user => self, :event => event)
    end

    def attending?(event)
      self.attendances.exists?(:event_id => event.id)
    end

    def attendance_for(event)
      self.attendances.where(:event_id => event.id).first
    end
end
