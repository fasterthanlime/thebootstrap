class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :url
      t.text :content
      t.references :user
      t.references :event

      t.timestamps
    end
  end
end
