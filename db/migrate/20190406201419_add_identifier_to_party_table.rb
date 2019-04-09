class AddIdentifierToPartyTable < ActiveRecord::Migration[5.2]
  def change
    add_column :parties, :identifier, :string
  end
end
