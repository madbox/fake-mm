class FrontController < ApplicationController
  def index
    @article = Article.last
  end
end
