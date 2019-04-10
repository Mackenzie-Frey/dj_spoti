class DropPartyUsersTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :party_users
  end
end
