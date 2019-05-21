class AddBookableStatusToTools < ActiveRecord::Migration[5.2]
  def change
    add_column :tools, :bookable, :boolean, default: true
  end
end
