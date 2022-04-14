class AddFlagToAlts < ActiveRecord::Migration[7.0]
  def change
    add_column :alts, :flag, :boolean
  end
end
