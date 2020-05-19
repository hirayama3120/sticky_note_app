class Api::UsersController < ApplicationController
  def user_task_list
    @users = User.all();
  end
end