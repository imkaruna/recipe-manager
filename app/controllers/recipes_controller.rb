class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :edit, :update, :remove, :destroy]
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  
  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    5.times do |i|
      @ingredient = @recipe.ingredients.build
    end
    @ingredients = Ingredient.all
  end

  def create
    @ingredients = Ingredient.all
    @recipe = Recipe.create(recipe_params)
    if @recipe.persisted?
      redirect_to recipe_path(@recipe)
    else
      5.times do |i|
        @ingredient = @recipe.ingredients.build
      end
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    # raise recipe_params.inspect
    @recipe.update!(recipe_params)
    if @recipe.persisted?
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end


  def destroy
    @recipe.destroy
    redirect_to root_path
  end

  private
  def recipe_params
    params.require(:recipe).permit(:name, :description,:instructions, :recipe_image, :recipe_ingredients_attributes => [:id, :quantity, :_destroy], :ingredients_attributes => [:id, :name, :quantity, :_destroy])
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
end
