class CreateVerifications < ActiveRecord::Migration[7.0]
  def change
    create_table :verifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :alt, null:false, foreign_key: true

      t.timestamps
    end

    add_index :verifcations, [:user_id, :alt_id], :unique =>  true 
  end
end
