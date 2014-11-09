class CreateTermostats < ActiveRecord::Migration
  def change
    create_table :termostats do |t|
      t.string :name
      t.float :setting
      t.float :temperature

      t.timestamps null: false
    end
  end
end
