class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.references :users
      t.references :events

      t.timestamps
    end
  end
end
