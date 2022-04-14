class AddVerificationsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :verifications, :integer, :default => 0
  end
end
