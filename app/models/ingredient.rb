class Ingredient < ActiveRecord::Base
  validates :name, uniqueness: true
  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients

  def quantity(recipe_id)
    RecipeIngredient.select("*").where(ingredient_id: self.id, recipe_id: recipe_id)[0].quantity
  end
  
end
