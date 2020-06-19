class Api::UsersController < ApplicationController
  def user_task_list
    @users = User.all();
  end

  def create
    begin
      @new_user_count = User.where('name like ?', 'New User%').size

      @user = User.new(name: "New User" + (@new_user_count + 1).to_s)

      if @user.save
        render json: @user, status: :created
      else
        @errors.push("failes to add user: user.save() failes")
        render :show_error
      end
    rescue => ex
      @errors.push("failed to add user: an exception occurred.")
      @errors.push(ex.to_s)
      render :show_error
    end
  end

end