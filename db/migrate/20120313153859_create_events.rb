class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.text :place
      t.datetime :occurs_at

      t.timestamps
    end
  end
end
