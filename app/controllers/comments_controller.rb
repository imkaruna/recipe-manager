class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_comment, only: [:show, :update, :delete]

  def index
    @comments = Comment.all
  end

  def new
    @comment = @recipe.comments.build
  end

  def create
    # raise params.inspect
    @recipe = Recipe.find(params[:comment][:recipe_id].to_i)
    @recipe.comments.create(comment_params)
      redirect_to recipe_path(@recipe)
  end

  private

  def find_comment
    if params[:recipe_id].nil?
      @comment = comment.find(params[:id])
    else
      @recipe = Recipe.find(params[:recipe_id])
      @comment = @recipe.comments.find(params[:id])
    end
    return @recipe, @comment
  end

  def comment_params
    params.require(:comment).permit(:user_id, :comment_text)
  end

end
