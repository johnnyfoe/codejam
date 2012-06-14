class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update, :destroy]
  #before_filter :admin_user, only: :destroy
  
  #This function is used to show a user based on an id passed in the params hash.
  #If the id that has been passed does not relate to a known user then a redirect to the index page happens.
  #To explain why there has been a redirect an error flash is displayed
  
  #To do:
    #Update so that users can be found by pseudonym as well as by id
  def show
    @user = User.find_by_id(params[:id])

    if !@user.nil?
      @ratings = @user.ratings.paginate(page: params[:page])
      return @user
    end
	
    @user = User.find_by_pseudonym(params[:id])
    if !@user.nil?
      @ratings = @user.ratings.paginate(page: params[:page])
      return @user
    end
	
    flash[:error] = "User #{params[:id]} does not exist."
    redirect_to root_path
  end
  
  #This function just initialises a user with empty params but doen't save it
  def new
    @user = User.new
  end
  
  #This function creates a user.
  #As a pseudonym is not required for sign up, but is required to make a user, one is generated from the users first
  #and second name. All spaces are removed and replaced with underscores.
  def create
    @user = User.new(params[:user])
    full_name = "#{@user.first_name} #{@user.surname}"
    full_name = full_name.gsub(" ", "_")
    count = 0
    while !( ( User.find_by_pseudonym("#{full_name}") ).nil? ) do
      count += 1
      puts count
      if( full_name.index(/_(\d+)/).nil? ) 
        full_name = full_name + "_#{count}"
      else
        full_name = full_name.gsub!(/_(\d+)$/, "_#{count}")
      end
    end
    @user.pseudonym = full_name
    
    if @user.save
      # handle a successful save
      sign_in @user
      flash[:success] = "Welcome to Codej.am! Before you get started you might want to change your aliases in settings."
      redirect_to user_path(@user.pseudonym)
    else
      render 'home/index'
    end
  end
  
  #Empty controller
  def edit
  end
  
  #This is used to display all the users available in a page format
  #This may be removed
  def index
    @users = User.paginate(page: params[:page])
  end
  
  #Update the user functionality when they edit their information.
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to user_path(@user.pseudonym)
      # Handle a successful update.
    else
      render 'edit'
    end
  end
  
  #Destroy the user, needs to be updated so that the user can delete themselves
  def destroy
    @user = User.find_by_id(params[:id])
    if !@user.nil?
      @user.destroy
      flash[:success] = "User destroyed."
      redirect_to(root_path)
    end
    @user = User.find_by_pseudonym(params[:id])
    if !@user.nil?
      @user.destroy
      flash[:success] = "User destroyed."
      redirect_to(root_path)
    end
  end
  
  private
  
  #Private function to only show certain parts of the site to signed in users
  def signed_in_user
    unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in." unless signed_in?
    end
  end
  
  #Private function to only show the related user info
  def correct_user
    @user = User.find_by_id(params[:id])
    if !@user.nil?
      redirect_to(root_path) unless current_user?(@user)
      return @user
    end
    @user = User.find_by_pseudonym(params[:id])
    if !@user.nil?
      redirect_to(root_path) unless current_user?(@user)
      return @user
    end
  end
  
  #Private function to check if a user is admin
  #This will be refactored out, users should be able to delete themselves rather than requiring an admin do it
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
