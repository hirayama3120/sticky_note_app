class Api::UsersController < ApplicationController
  def user_task_list
    @users = User.all();
  end

  def create_user
    @user = User.create(name: "New User")

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :internal_server_error
    end
  end
end