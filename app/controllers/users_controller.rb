class UsersController < ApplicationController
  def index
    if find_user
      @users = User.all
    else
      redirect_to root_path
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    render_404 unless @user
  end
end
