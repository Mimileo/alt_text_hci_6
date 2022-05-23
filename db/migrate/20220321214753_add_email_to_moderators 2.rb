class AddEmailToModerators < ActiveRecord::Migration[7.0]
  def change
    add_column :moderators, :email, :string
  end
end
