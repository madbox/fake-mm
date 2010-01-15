class AssigmentsController < ApplicationController
  # GET /assigments
  # GET /assigments.xml
  def index
    @assigments = Assigment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @assigments }
    end
  end

  # GET /assigments/1
  # GET /assigments/1.xml
  def show
    @assigment = Assigment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @assigment }
    end
  end

  # GET /assigments/new
  # GET /assigments/new.xml
  def new
    @assigment = Assigment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @assigment }
    end
  end

  # GET /assigments/1/edit
  def edit
    @assigment = Assigment.find(params[:id])
  end

  # POST /assigments
  # POST /assigments.xml
  def create
    @assigment = Assigment.new(params[:assigment])

    respond_to do |format|
      if @assigment.save
        flash[:notice] = 'Assigment was successfully created.'
        format.html { redirect_to(@assigment) }
        format.xml  { render :xml => @assigment, :status => :created, :location => @assigment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @assigment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /assigments/1
  # PUT /assigments/1.xml
  def update
    @assigment = Assigment.find(params[:id])

    respond_to do |format|
      if @assigment.update_attributes(params[:assigment])
        flash[:notice] = 'Assigment was successfully updated.'
        format.html { redirect_to(@assigment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @assigment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /assigments/1
  # DELETE /assigments/1.xml
  def destroy
    @assigment = Assigment.find(params[:id])
    @assigment.destroy

    respond_to do |format|
      format.html { redirect_to(assigments_url) }
      format.xml  { head :ok }
    end
  end
end
