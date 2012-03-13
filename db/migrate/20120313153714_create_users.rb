class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nick
      t.string :auth_hash
      t.datetime :last_seen

      t.timestamps
    end
  end
end
