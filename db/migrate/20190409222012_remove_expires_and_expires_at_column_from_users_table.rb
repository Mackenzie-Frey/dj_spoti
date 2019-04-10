class RemoveExpiresAndExpiresAtColumnFromUsersTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :expires
    remove_column :users, :expires_at
  end
end
