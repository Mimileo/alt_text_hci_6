class CreateModerators < ActiveRecord::Migration[7.0]
  def change
    create_table :moderators do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.boolean :super_admin
      t.boolean :referee
      t.boolean :contributor
      t.boolean :flag

      t.timestamps
    end
  end
end
