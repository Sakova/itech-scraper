class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if current_user
      @articles = current_user.articles
    end
  end
end
