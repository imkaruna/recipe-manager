class RecipeIngredient < ActiveRecord::Base
  validates :quantity, presence: true
  belongs_to :recipe
  belongs_to :ingredient

end
