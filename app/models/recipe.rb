class Recipe < ActiveRecord::Base
  validates :name, presence: true
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  def ingredients_attributes=(ingredients_attributes)
    ingredients_attributes.each do |k|
      if (!k["id"].nil? && !k["quantity"].nil? && unique_ingredient?( k["id"].to_i))
        ingredients = Ingredient.where("id in (?)", k["id"].to_i)
        self.recipe_ingredients.build(ingredient_id: k["id"].to_i, quantity: k["quantity"])
      end
    end
  end

  private
  def unique_ingredient?(ingredient_id)
    if self.recipe_ingredients.include?(ingredient_id)
      false
    else
      true
    end
  end
end
