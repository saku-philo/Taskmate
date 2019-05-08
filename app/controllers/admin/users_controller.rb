class Admin::UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create,]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "ユーザーを新規登録しました！"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.includes(:tasks).all.order('id')
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "「#{@user.name}」さんの情報を更新しました！"
    else
      render :edit_admin_user_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, alert: "「#{@user.name}」さんの情報を削除しました！"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
