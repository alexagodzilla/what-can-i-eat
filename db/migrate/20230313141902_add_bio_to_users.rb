class AddBioToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :bio, :string
    add_column :users, :diet, :string
    add_column :users, :image_url, :string
  end
end
