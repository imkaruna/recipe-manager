class IngredientsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :show, :edit, :update, :remove, :destroy]
  before_action :find_ingredient, only: [:show, :edit, :update, :destroy]
  #
  def index
    @ingredients = Ingredient.all
  end
  #
  def new
    if !params[:recipe_id].nil?
      @recipe = Recipe.find(params[:recipe_id])
      @ingredient = @recipe.ingredients.build
    end
    @ingredient = Ingredient.new
    session[:referrer] = request.referer # saving route for redirect_to
  end
  #
  def create
    if params[:recipe_id].nil?
      @ingredient = Ingredient.create(ingredient_params)
      redirect_to ingredients_path
    else
      @recipe = Recipe.find(params[:recipe_id])
      @ingredient = @recipe.ingredients.build(ingredient_params)
      if @ingredient.save
        redirect_to recipe_path(@recipe)
      else
        render 'new'
      end
    end
  end
  #
  def edit
    @ingredient = Ingredient.find(params[:id])
    unless params[:recipe_id].nil?
      @recipe = Recipe.find(params[:recipe_id])
      @quantity = @recipe.recipe_ingredients.find_by(ingredient_id: @ingredient.id).quantity
    end
  end
  #
  #Saving the following code if in future I want individual ingredients to be updated
  # def update
  #   if params[:recipe_id].nil?
  #     @ingredient = Ingredient.find(params[:id])
  #     @ingredient.update(ingredient_params)
  #     redirect_to ingredients_path
  #   else
  #     @recipe = Recipe.find(params[:recipe_id])
  #     @ingredient = @recipe.ingredients.build(ingredient_params)
  #     @ingredient.update(ingredient_params)
  #     redirect_to recipe_path(@recipe)
  #   end
  #
  # end
  #
  def show
    redirect_to recipe_path(@recipe)
  end
  #
  def destroy
  if params[:recipe_id].nil?
     @ingredient.destroy
     redirect_to ingredients_path
   else
     @ingredient.recipe_ingredients.find_by(ingredient_id: params[:id]).delete
     redirect_to recipe_path(@recipe)
   end
  end
  #
  private
  def find_ingredient
    if params[:recipe_id].nil?
      @ingredient = Ingredient.find(params[:id])
    else
      @recipe = Recipe.find(params[:recipe_id])
      @ingredient = @recipe.ingredients.find(params[:id])
    end
    return @recipe, @ingredient
  end
  #
  def ingredient_params
    params.require(:ingredient).permit(:name)
  end
end
