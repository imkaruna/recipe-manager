class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient

  # def self.quantity
  #   self.quantity
  # end
end
