class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nick
      t.string :auth_hash

      # twitter credentials
      t.string :token
      t.string :secret

      t.datetime :last_seen

      t.timestamps
    end

    add_index :users, :auth_hash
  end
end
