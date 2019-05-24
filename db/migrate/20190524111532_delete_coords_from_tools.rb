class DeleteCoordsFromTools < ActiveRecord::Migration[5.2]
  def change
    remove_column :tools, :longitude, :float
    remove_column :tools, :latitude, :float
  end
end
