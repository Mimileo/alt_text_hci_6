class CreateAltFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :alt_favorites do |t|
      t.integer :alt_id
      t.integer :user_id

      t.timestamps
    end
  end
end
