class UsersController < ApplicationController
  def index
    @users = User.order(:name)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      helpers.flash_success("User successfully created.")

    
    else
      helpers.flash_errors_for(@user)
    end
    redirect_to action: "new"
  end

  def edit
    @users = User.order(:name)
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      helpers.flash_success("User updated successfully")
      redirect_to action: "index"
    else
      helpers.flash_errors_for(@user)
      redirect_to action:"edit", id: params[:id]
    end
  end

  def markfordeath
    @users = User.order(:name)
    @user = User.new
  end

  def destroy
    @user = User.find(params[:id])
    if @user
        @user.destroy()
        helpers.flash_success("User successfully deleted")
    else
        flash[:danger] = "User to be deleted not found"
    end
    redirect_to action: "markfordeath"
  end
  

  private

  def user_params
    params.require(:user).permit(:name, :password, :admin, :exec, :start_date, :end_date, :min_confidence, :max_confidence)
  end
end
