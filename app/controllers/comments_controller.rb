class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_comment, only: [:show, :update, :delete]

  def index
    @comments = Comment.all
  end

  def new
    @comment = current_user.comments.build
  end

  def create
    @recipe = Recipe.find(params[:comment][:recipe_id].to_i)
    @comment = current_user.comments.build(comment_params)
    @recipe.comments << @comment
    respond_to do |format|
      format.html { redirect_to recipe_path(@recipe)  }
      format.json { render :json => {:comment_text => @comment.comment_text,
                                  :user_email => current_user.email }  }
    end
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
    params.require(:comment).permit(:user_id, :comment_text, :recipe_id)
  end

end
