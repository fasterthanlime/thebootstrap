class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nick
      t.string :auth_hash
      t.datetime :first_seen
      t.datetime :last_seen

      t.timestamps
    end

    add_index :users, :auth_hash
  end
end
