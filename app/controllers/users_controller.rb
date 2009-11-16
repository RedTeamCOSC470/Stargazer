class UsersController < ApplicationController
  def new  
    @user = User.new  
  end  
    
  def create  
    @user = User.new(params[:user])  
    if @user.save  
      flash[:notice] = "Registration successful."  
      redirect_to users_path
    else  
      render :action => 'new'  
    end  
  end 
  
  def edit  
    @user = current_user  
  end  
    
  def update  
    @user = current_user  
    if @user.update_attributes(params[:user])  
      flash[:notice] = "Successfully updated profile."  
      redirect_to root_url  
    else  
      render :action => 'edit'  
    end  
  end  
  
  def index
  	@users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  def destroy
    @user = Schedule.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
