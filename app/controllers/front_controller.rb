class FrontController < ApplicationController
  def index
    redirect_to current_user if current_user
    @article = Article.news.most_important.first
  end
end
