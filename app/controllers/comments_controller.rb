class CommentsController < ApplicationController
  filter_access_to :all, :attribute_check => true
  # filter_resource_access

  # GET /comments
  # GET /comments.xml
  def index
#    raise ( user = User.find_by_id( params[:user_id].to_i ) ).kind_of?( User ).inspect
    if !params[:user_id].blank? && ( user = User.find_by_id( params[:user_id].to_i ) ).kind_of?( User )
      @comments = user.comments
    else
      @comments = Comment.find( :all, :order => "id DESC" )
    end
    @grouped_comments = @comments.group_by( &:article )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @article = Article.find(params[:article_id])
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    @comment.article = Article.find(params[:article_id]) unless @comment.article
  end

  # POST /comments
  # POST /comments.xml
  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.article = Article.find(params[:comment][:article_id].to_i)

    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully created.'
        format.html { redirect_to(@comment.article) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { redirect_to(:back) }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(@comment.article) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(@comment.article) }
      format.xml  { head :ok }
    end
  end
end
