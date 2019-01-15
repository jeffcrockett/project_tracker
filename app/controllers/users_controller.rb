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
      @user = User.new
    end
    render "new"
  end

  def edit
    @users = User.order(:name)
    @user = User.find(params[:id])
  end

  def update
    @users = User.order(:name)
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      render "index"
    else
      render "edit"
    end
  end

  def markfordeath
    @users = User.order(:name)
    @user = User.new
  end

  def destroy
    @users = User.order(:name)
    @user = User.find(params[:id])
    if @user
        @user.destroy()
        @user = User.new
    end
    render "markfordeath"
  end
  

  private

  def user_params
    params.require(:user).permit(:name, :password, :admin, :exec, :start_date, :end_date, :min_confidence, :max_confidence)
  end
end
