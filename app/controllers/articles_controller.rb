class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      flash[:notice] = "Article was successfully created."
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was successfully updated."
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy!
    flash[:notice] = "Project was successfully destroyed"
    redirect_to root_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:link, :title)
  end
end