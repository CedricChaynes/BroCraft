class ChangeAddressTypeFromStringToTextFieldInUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :address, :text
  end
end
