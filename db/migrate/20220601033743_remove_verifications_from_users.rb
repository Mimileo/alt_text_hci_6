class RemoveVerificationsFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :verifications, :integer
  end
end
