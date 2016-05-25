class Recipe < ActiveRecord::Base
  has_attached_file :recipe_image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: ":style/default.png"
  validates_attachment_content_type :recipe_image, content_type: /\Aimage\/.*\Z/

  validates :name,:instructions, presence: true
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  attr_accessor :quantity

  def ingredients_attributes=(ingredients_attributes)
    ingredients_attributes.each do |key, ingredient_attr|
      if (!(ingredient_attr.values.any? &:blank?) && unique_ingredient?( ingredient_attr["id"].to_i))
        self.recipe_ingredients.build(ingredient_id: ingredient_attr["id"].to_i, quantity: ingredient_attr["quantity"])
      else
        self.errors.add(:quantity, 'Cannot be blank')
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
