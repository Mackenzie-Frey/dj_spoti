class CreateParties < ActiveRecord::Migration[5.2]
  def change
    create_table :parties do |t|
      t.string :name
      t.integer :admin

      t.timestamps
    end
  end
end
