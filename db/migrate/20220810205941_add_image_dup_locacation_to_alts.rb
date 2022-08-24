class AddImageDupLocacationToAlts < ActiveRecord::Migration[7.0]
  def change
    add_column :alts, :image_dup_locate, :integer
  end
end
