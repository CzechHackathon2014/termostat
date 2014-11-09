class TermostatApiController < ApplicationController

  def submit_temperature

    tm = Termostat.find_by_termostat_id(params[:term_id])

    tm.currentTemperature = params[:temperature]

    tm.save!

    measurement = Measurement.new
    measurement.termostat_id = tm.termostat_id
    measurement.temperature = params[:temperature]
;
    measurement.save!

    render plain: "test"
  end

  def update_temperature
    tm = Termostat.find_by_termostat_id(params[:term_id])

    if (tm.temperature > tm.currentTemperature) && tm.setting > 20
      tm.setting = tm.setting - 10
    elsif (tm.temperature < tm.currentTemperature) && tm.setting < 160
      tm.setting = tm.setting + 10

    end

    tm.save!


    render html: tm.setting.to_i.to_s
  end

  def termostats

    render json: Termostat.all
  end

  def add_termostat

    termostat = Termostat.new
    termostat.name = params[:name]
    termostat.termostat_id = params[:termostat_id]
    termostat.temperature = params[:temperature]
    termostat.currentTemperature = 20.0
    termostat.setting = 1.0

    termostat.save!


    render json: {}, status: 200
  end

  def update_termostat

    termostat = Termostat.find_by_termostat_id(params[:termostat_id])

    termostat.name = params[:name]
    termostat.temperature = params[:temperature]

    termostat.save!

    render json: {}, status: 200
  end
end
