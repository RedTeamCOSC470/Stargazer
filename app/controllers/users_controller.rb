class UsersController < ApplicationController
  before_filter :require_user
  before_filter :authorize, :except => [:edit, :update]
  
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
  	if admin?
      @user = User.find(params[:id])
    else
	  @user = @current_user
end
  end  
    
  def update  
    if admin? 
      @user = User.find(params[:id])
    else
	  @user = @current_user	
    end
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
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
