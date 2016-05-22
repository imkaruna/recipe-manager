class IngredientsController < ApplicationController

  def index
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.create(ingredient_params)
    if @ingredient.persisted?
      redirect_to root_path
    end
  end

  def show
  end

  def delete
    @recipe = Recipe.find(params[:post_id])
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy

  end

  private

  def ingredient_params
    params.require(:recipe).permit(params[:id], :name)
  end
end
