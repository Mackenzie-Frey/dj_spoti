class RemoveAdminIdFromParties < ActiveRecord::Migration[5.2]
  def change
    remove_column :parties, :admin
  end
end
