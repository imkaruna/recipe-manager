class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    @ingredient = Ingredient.new
    # binding.pry
    @ingredients = Ingredient.all
  end

  def create
    @ingredients = Ingredient.all
    # @ingredient = Ingredient.create(ingredient_params)
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      flash[:notice] = "Error saving the recipe.."
      render 'new'
    end
  end

  def show
    make_ingredients_hash
  end

  def edit
    flash[:notice] = "Successfully created..."
    make_ingredients_hash
  end

  def update
    binding.pry
    @recipe.update(recipe_params)
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
    params.require(:recipe).permit(:name, :description,  :ingredients_attributes => [:id, :quantity, :_destroy])
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])

  end

  def make_ingredients_hash
    @recipe_ingredients = @recipe.recipe_ingredients
    @ingredient_name_hash =  @recipe.ingredients.map {|x| [x.id ,x.name]}.to_h
  end
end
