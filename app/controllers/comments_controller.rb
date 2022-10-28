class CommentsController < ApplicationController
  before_action :set_comment, only: [:show]

  def show
  end

  def create
    response = CommentsCreation.new(comment_params[:original_comments], comment_params[:translated_comments], comment_params[:article_id]).rating

    if response
      render json: {
        response: true
      }
    else
      render json: {
        response: false
      }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:article_id, original_comments: [], translated_comments: [])
  end
end
