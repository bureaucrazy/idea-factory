class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to root_path
    else
      flash[:alert] = "Oops.."
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.authenticate(params[:user][:current_password])
      if @user.update user_params
        redirect_to edit_users_path, notice: "User details saved."
      else
        flash[:alert] = "Oops.."
        render :edit
      end
    else
      flash[:alert] = "Validation required."
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email,
                                 :password,
                                 :password_confirmation)
   end

end
