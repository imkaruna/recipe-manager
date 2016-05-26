class Ingredient < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true
  attr_accessor :quantity
  # attr_reader :name

  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients

  def quantity_for_recipe(recipe_id)
    # binding.pry
    self.recipe_ingredients.find_by(recipe_id: recipe_id).quantity
  end
end
