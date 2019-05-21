class RenameUserToRenterInBooking < ActiveRecord::Migration[5.2]
  def change
    rename_column :bookings, :user_id, :renter_id
  end
end
