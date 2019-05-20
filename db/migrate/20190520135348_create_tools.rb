class CreateTools < ActiveRecord::Migration[5.2]
  def change
    create_table :tools do |t|
      t.string :name
      t.text :description
      t.string :category
      t.integer :price_per_day
      t.string :photo_url

      t.timestamps
    end
  end
end
