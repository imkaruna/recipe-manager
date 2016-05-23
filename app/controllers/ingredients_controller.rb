class IngredientsController < ApplicationController

  def index
  end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient = @recipe.ingredients.build
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient = Ingredient.create(ingredient_params)
    # binding.pry
    @recipe.recipe_ingredients.build(ingredient_id: @ingredient.id, quantity: params[:quantity])
    @recipe.save
    redirect_to edit_recipe_path(@recipe.id)

  end

  def edit
    recipe = Recipe.find(params[:recipe_id])
    @quantity = recipe.recipe_ingredients.find_by(ingredient_id: params[:id]).quantity
    @ingredient = Ingredient.find(params[:id])
    # binding.pry
  end

  def update
    recipe = Recipe.find(params[:recipe_id])
    @ingredient = Ingredient.find(params[:id])
    @ingredient.update(ingredient_params)
    @ingredient.update_quantity(recipe, params[:ingredient][:quantity])
    redirect_to session[:referrer]

  end

  def show
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient = RecipeIngredient.find_by(ingredient_id: params[:id])
    @ingredient.destroy
    redirect_to session[:referrer]

  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name)
  end
end
