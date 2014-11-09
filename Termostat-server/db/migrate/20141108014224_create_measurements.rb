class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.float :temperature
      t.datetime :time
      t.float :setting
      t.belongs_to :termostat

      t.timestamps null: false
    end
  end
end
