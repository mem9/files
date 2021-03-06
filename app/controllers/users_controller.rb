# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :index, @user, :message => 'Необходимо авторизироваться как "Администратор".'
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.create( user_params )
  end


  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])

      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end


    
  def destroy
    authorize! :destroy, @user, :message => 'Необходимо авторизироваться как "Администратор".'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "Пользователь удален"
    else
      redirect_to users_path, :notice => "Нельзя удалить самого себя"
    end
  end

  private

# Use strong_parameters for attribute whitelisting
# Be sure to update your create() and update() controller methods.

  def user_params
    params.require(:user).permit(:avatar,:role_ids)
  end

end
