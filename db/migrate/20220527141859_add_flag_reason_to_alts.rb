class AddFlagReasonToAlts < ActiveRecord::Migration[7.0]
  def change
    add_column :alts, :flag_reason, :string
  end
end
