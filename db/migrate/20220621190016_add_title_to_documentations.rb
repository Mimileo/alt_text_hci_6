class AddTitleToDocumentations < ActiveRecord::Migration[7.0]
  def change
    add_column :documentations, :title, :string
  end
end
