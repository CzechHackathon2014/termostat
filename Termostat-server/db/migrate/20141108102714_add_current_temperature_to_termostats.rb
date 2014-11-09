class AddCurrentTemperatureToTermostats < ActiveRecord::Migration
  def change
    add_column :termostats, :currentTemperature, :float
  end
end
