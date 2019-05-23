class ChangeAdressTypeOnUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :address, :string
  end
end
