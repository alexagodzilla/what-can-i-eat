class CreateSteps < ActiveRecord::Migration[7.0]
  def change
    create_table :steps do |t|
      t.integer :number
      t.text :content
      t.string :recipe
      t.string :references

      t.timestamps
    end
  end
end
