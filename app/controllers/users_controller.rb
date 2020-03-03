class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:follow]

  def show
    @user = User.find(params[:id])
  end

  def follow
    @user = User.find(params[:id])
    if current_user.following?(@user)
      current_user.following.delete(@user)
      flash[:notice] = "Already following. Unfollowed"
    else
      current_user.following << @user
    end

    redirect_to user_path(@user)
  end
end
