class AddCheckPerformedToAlts < ActiveRecord::Migration[7.0]
  def change
    add_column :alts, :check_performed, :boolean
  end
end
