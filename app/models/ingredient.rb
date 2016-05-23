class Ingredient < ActiveRecord::Base
  validates :name, uniqueness: true
  attr_accessor :quantity

  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients


  def update_quantity(recipe, quantity)
    recipe_with_this_ingredient = self.recipe_ingredients.find_or_create_by(recipe_id: recipe.id)
    recipe_with_this_ingredient.quantity = quantity
    recipe_with_this_ingredient.save
  end
end
