class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :instructions
      t.integer :prep_time
      t.integer :cooking_time
      t.integer :serving_size
      t.string :image_url

      t.timestamps
    end
  end
end
