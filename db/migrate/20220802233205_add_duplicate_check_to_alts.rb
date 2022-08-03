class AddDuplicateCheckToAlts < ActiveRecord::Migration[7.0]
  def change
    add_column :alts, :duplicate_check, :boolean
  end
end
