class CreateAlts < ActiveRecord::Migration[7.0]
  def change
    create_table :alts do |t|
      t.text :image_data
      t.string :title
      t.string :original_url
      t.string :original_source
      t.boolean :verified, :default => false
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
