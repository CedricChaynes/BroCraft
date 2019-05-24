class DeleteBookabilityFromTools < ActiveRecord::Migration[5.2]
  def change
    remove_column :tools, :bookable, :boolean
  end
end
