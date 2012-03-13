class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :url
      t.text :content
      t.references :attendance

      t.timestamps
    end

    add_index :feedbacks, :attendance_id
  end
end
