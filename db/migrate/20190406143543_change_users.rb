class ChangeUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :expires, :boolean
    add_column :users, :expires_at, :integer
  end
end
