class AddTermostatIdToTermostats < ActiveRecord::Migration
  def change
    add_column :termostats, :termostat_id, :integer
  end
end
