class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.boolean :like
      t.integer :article_id, :user_id
      t.timestamps
    end
  end
end
