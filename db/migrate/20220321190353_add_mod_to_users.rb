class AddModToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :contributor, :boolean
    add_column :users, :flag, :boolean
    add_column :users, :referee, :boolean
  end
end
