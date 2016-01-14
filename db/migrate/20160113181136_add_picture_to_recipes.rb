class AddPictureToRecipes < ActiveRecord::Migration
  def change
    add_column :articles, :picture, :string
  end
end
