class AddAttachmentRecipeImageToRecipes < ActiveRecord::Migration
  def self.up
    change_table :recipes do |t|
      t.attachment :recipe_image
    end
  end

  def self.down
    remove_attachment :recipes, :recipe_image
  end
end
