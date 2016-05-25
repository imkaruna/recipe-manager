class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :edit, :update, :remove, :destroy]
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  # before_action :make_ingredients_hash, only: [:show, :edit, :update]
  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    @ingredient = @recipe.ingredients.build
    # binding.pry
    @ingredients = Ingredient.all
  end

  def create
    @ingredients = Ingredient.all
    @recipe = Recipe.create!(recipe_params)
    if @recipe.persisted?
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    # raise params.inspect
    @recipe.update!(recipe_params)
    if @recipe.persisted?
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end

  def remove
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient = @recipe.recipe_ingredients.find_by(ingredient_id: params[:id])
    @ingredient.destroy
    redirect_to edit_recipe_path(@recipe)
  end

  def destroy
    @recipe.destroy
    redirect_to root_path
  end

  private
  def recipe_params
    params.require(:recipe).permit(:name, :description,:instructions, :recipe_image, :ingredients_attributes => [:id, :quantity, :_destroy])
  end

  def find_recipe
    if params[:recipe_id].nil?
      @recipe = Recipe.find(params[:id])
    else
      @recipe = Recipe.find(params[:recipe_id])
      @ingredient = @recipe.ingredients.build
      return @recipe, @ingredient
    end
  end

  # def make_ingredients_hash
  #   # binding.pry
  #   @recipe.recipe_ingredients.collect {|i| [i.ingredient.name, i.quantity]}
  #
  #   # @recipe_ingredients=@recipe.recipe_ingredients.collect {|i| [i.ingredient_id=>[i.ingredient.name, i.quantity]]}.flatten
  # end
end
