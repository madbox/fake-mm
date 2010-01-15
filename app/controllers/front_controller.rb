class FrontController < ApplicationController
  def index
    @article = Article.news.last
  end
end
