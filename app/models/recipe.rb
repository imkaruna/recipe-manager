class Recipe < ActiveRecord::Base
  has_attached_file :recipe_image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: ":style/default.png"
  validates_attachment_content_type :recipe_image, content_type: /\Aimage\/.*\Z/

  validates :name,:instructions, presence: true
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  attr_accessor :quantity

  def ingredients_attributes=(ingredients_attributes)
    # binding.pry
    ingredients_attributes.each do |key, ingredient_attr|
      if (!(ingredient_attr.values.any? &:blank?))
        ingredient = Ingredient.find_or_create_by(name: ingredient_attr["name"])
        self.recipe_ingredients.build(ingredient_id: ingredient.id,quantity: ingredient_attr["quantity"])
      end
    end
  end

  def recipe_ingredients_attributes=(recipe_ingredients_attributes)
    recipe_ingredients_attributes.each do |key, ingredient_attr|
      if (!(ingredient_attr.values.any? &:blank?))
        self.recipe_ingredients.build(ingredient_id: ingredient_attr["id"].to_i, quantity: ingredient_attr["quantity"])
      else
        self.errors.add(:quantity, 'Cannot be blank')
      end
    end
  end

  def self.recently_added_recipes
    #binding.pry
    Recipe.last(5).reverse
  end

end
