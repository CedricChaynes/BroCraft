class AddOwnerToTool < ActiveRecord::Migration[5.2]
  def change
    add_reference :tools, :owner, foreign_key: { to_table: :users }
  end
end
