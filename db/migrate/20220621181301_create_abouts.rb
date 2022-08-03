class CreateAbouts < ActiveRecord::Migration[7.0]
  def change
    create_table :abouts do |t|
      t.text :body
      t.text :description
      t.text :seo

      t.timestamps
    end
  end
end
