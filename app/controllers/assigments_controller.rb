class AssigmentsController < ApplicationController
  # POST /assigments
  # POST /assigments.xml
  def create
    @assigment = Assigment.new(params[:assigment])

    respond_to do |format|
      if @assigment.save
        flash[:notice] = 'Assigment was successfully created.'
        format.html { redirect_to edit_user_path( @assigment.user ) }
        format.xml  { render :xml => @assigment, :status => :created, :location => @assigment }
      else
        flash[:error] = 'Failed to add assigment.'
        format.html { redirect_to :back }
        format.xml  { render :xml => @assigment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /assigments/1
  # DELETE /assigments/1.xml
  def destroy
    @user = User.find params[:user_id]
    @role = Role.find params[:id]

    @user.roles.delete @role
    flash[:notice] = 'Assigment was successfully destroyed.'

    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
end
