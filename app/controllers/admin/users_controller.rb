class Admin::UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create,]
  before_action :check_admin

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
    if @user.destroy
      redirect_to admin_users_path, alert: "「#{@user.name}」さんの情報を削除しました！"
    else
      redirect_to admin_users_path, alert: "管理者がいなくなるため、削除出来ません"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def check_admin
    unless current_user.admin?
      raise Forbidden
    end
  end
end