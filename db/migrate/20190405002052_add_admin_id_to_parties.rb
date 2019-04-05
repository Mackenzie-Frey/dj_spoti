class AddAdminIdToParties < ActiveRecord::Migration[5.2]
  def change
    add_reference :parties, :user, foreign_key: true
    rename_column :parties, :user_id, :admin_id
  end
end
