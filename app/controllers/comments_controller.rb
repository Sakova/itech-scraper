class CommentsController < ApplicationController
  before_action :set_comment, only: [:show]
  before_action :comment_params, only: [:create]

  def show
  end

  def create
    status = CreateComments.new(comment_params['original_comments'], comment_params[:translated_comments], comment_params[:article_id]).rating

    if status
      render json: {
        status: true
      }
    else
      render json: {
        status: false
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