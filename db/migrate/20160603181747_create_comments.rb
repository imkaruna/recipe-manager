class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment_text
      t.integer :user_id
      t.integer :recipe_id
    end
  end
end
