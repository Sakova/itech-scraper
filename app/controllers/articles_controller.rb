class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, except: [:create, :new]

  def show
    @comments = @article.comments.paginate(page: params[:page], per_page: 10)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    data = SiteScraper.new(@article.link).scraper
    @article.title = data[:title]
    @article.user = current_user
    if @article.save
      render json: {
        original_comments: data[:original_comments],
        translated_comments: data[:translated_comments],
        article_id: @article.id
      }
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

  def require_same_user
    if current_user != @article.user
      flash[:alert] = "You can only edit or delete your own article"
      redirect_to root_path
    end
  end
end
