class ArticlesController < ApplicationController
  filter_access_to :all, :attribute_check => true

  # GET /articles
  # GET /articles.xml
  def index
    @articles = Article.published

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
    end
  end

  def editor
    @articles = Article.paginate :page => params[:page], :order => 'updated_at DESC'
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
    end
  end

  def drafts
    @articles = Article.drafts.paginate :page => params[:page]
#    raise @articles.inspect

    respond_to do |format|
      format.html { render 'editor' }# index.html.erb
      format.xml  { render :xml => @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = Article.find_by_sysname(params[:id])
    @pictures_only = params[:pictures]
    @article.update_attribute( :views_count, @article.views_count + 1 )

    @comment = Comment.new

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = Article.new
    @categories = Category.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find_by_sysname(params[:id])
    @categories = Category.all
  end

  # POST /articles
  # POST /articles.xml
  def create
    @article = Article.new(params[:article]) 
    @categories = Category.all
   
    @article.user = current_user
    
    respond_to do |format|
      if @article.save
        flash[:notice] = 'Article was successfully created.'
        format.html { redirect_to(@article) }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.xml
    @categories = Category.all
  def update
    @article = Article.find_by_sysname(params[:id])
    @categories = Category.all

    respond_to do |format|
      if @article.update_attributes(params[:article])
        flash[:notice] = 'Article was successfully updated.'
        format.html { redirect_to(@article) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @article = Article.find_by_sysname(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml  { head :ok }
    end
  end

  def undraft
    @article = Article.find_by_sysname(params[:id])

    if @article.undraft
      flash[:notice] = I18n.t('notice.article_undrafted')
    else
      flash[:notice] = I18n.t('errors.article_undrafting_failed')
    end

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.js 
      format.xml  { head :ok }
    end
  end

  def to_drafts
    @article = Article.find_by_sysname(params[:id])

    if @article.make_draft
      flash[:notice] = I18n.t('notice.article_drafted')
    else
      flash[:notice] = I18n.t('errors.article_drafting_failed')
    end

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.js 
      format.xml  { head :ok }
    end
  end

  def publish
    @article = Article.find_by_sysname(params[:id])
    if @article.publish
      flash[:notice] = I18n.t('notice.article_published')
    else
      flash[:notice] = I18n.t('else.article_publishing_failed')
    end

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.js 
      format.xml  { head :ok }
    end
  end

  def unpublish
    @article = Article.find_by_sysname(params[:id])
    if @article.unpublish
      flash[:notice] = I18n.t('notice.article_unpublished')
    else
      flash[:notice] = I18n.t('else.article_unpublishing_failed')
    end

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.js 
      format.xml  { head :ok }
    end
  end

  def next_news
    unless @article = Article.published.news.most_important.find(:first, :conditions => { :publish_date_gt => Article.find( params[:id] ).publish_date}, :order => "publish_date" )
      @article = Article.find(params[:id]) if @article.nil?
    end
    
    respond_to do |f|
      f.js
    end
  end

  def prev_news
    unless @article = Article.published.news.most_important.find(:first, :conditions => { :publish_date_lt => Article.find( params[:id] ).publish_date}, :order => "publish_date DESC" )
      @article = Article.find(params[:id]) if @article.nil?
    end
    
    respond_to do |f|
      f.js
    end
  end
end
