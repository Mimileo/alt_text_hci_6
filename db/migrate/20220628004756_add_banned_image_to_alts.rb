class AddBannedImageToAlts < ActiveRecord::Migration[7.0]
  def change
    add_column :alts, :banned_image, :boolean
  end
end
