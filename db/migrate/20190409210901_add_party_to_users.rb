class AddPartyToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :party, foreign_key: true
  end
end
