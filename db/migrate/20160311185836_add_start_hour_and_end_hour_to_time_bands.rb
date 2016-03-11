class AddStartHourAndEndHourToTimeBands < ActiveRecord::Migration
  def change
    add_column :time_bands, :start_hour, :string
    add_column :time_bands, :end_hour, :string
  end
end
