class FrontController < ApplicationController
  before_filter :prepare_news

  def index
#    redirect_to current_user if current_user
    @article = Article.published.news.most_important.first
    
    if cat = Category.find_by_sysname('features')
#      raise Article.published.scoped_by_category_id( cat.id ).find(:all, :limit => 2).inspect
      @feature0, @feature1 = *(Article.published.scoped_by_category_id( cat.id ).find(:all, :limit => 2, :order => 'publish_date DESC'))
      # @feature0 = cat.articles.first  if cat.articles.size > 0
      # @feature1 = cat.articles.second if cat.articles.size > 1
    end

    if cat = Category.find_by_sysname('review')
      @review = Article.published.scoped_by_category_id( cat.id ).first
    end

    @hide_news_line = true
    @hide_user_sidebar = true
  end
end
