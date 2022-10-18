class CommentsController < ApplicationController
  before_action :set_comment, only: [:show]

  def show
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text, :rating)
  end
end