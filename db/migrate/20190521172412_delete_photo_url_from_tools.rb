class DeletePhotoUrlFromTools < ActiveRecord::Migration[5.2]
  def change
    remove_column :tools, :photo_url
  end
end
