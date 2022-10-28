class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    flash.now[:notice] = "Article successfully created." if params[:success] == "true"
    flash.now[:alert] = "There is an error. Article didn't create." if params[:success] == "false"
    if current_user
      @articles = current_user.articles.paginate(page: params[:page], per_page: ARTICLES_PER_PAGE)
    end
  end
end
