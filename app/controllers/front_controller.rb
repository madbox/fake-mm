class FrontController < ApplicationController
  def index
    @articles = Article.all
  end
end
