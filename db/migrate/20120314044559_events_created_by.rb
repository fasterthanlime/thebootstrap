class EventsCreatedBy < ActiveRecord::Migration
  def change
    add_column :events, :creator_id, :integer
  end
end
