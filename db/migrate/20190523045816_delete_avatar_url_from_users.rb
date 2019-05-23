class DeleteAvatarUrlFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :avatar_url, :string
  end
end
