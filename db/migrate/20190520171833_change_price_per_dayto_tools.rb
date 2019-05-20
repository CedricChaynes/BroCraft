class ChangePricePerDaytoTools < ActiveRecord::Migration[5.2]
  def change
    change_column :tools, :price_per_day, :decimal, precision: 10, scale: 2
  end
end
