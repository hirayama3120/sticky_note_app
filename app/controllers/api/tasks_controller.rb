class Api::TasksController < ApplicationController
  def switch_user
    @errors = [];

    suparam = switch_user_params();

    begin
      # タスクデータを取得
      @task = Task.find(suparam[:task_id]);

      # ユーザデータを取得
      @user = User.find(suparam[:user_id]);

      # タスク所有者を変更
      @task.user = @user;

      # タスクデータを更新
      if ! @task.save then
        @errors.push("failed to switch user: task.save() faield");
        render :show_error
      end

    rescue => ex
      @errors.push("failed to switch user: an exception occurred.");
      @errors.push(ex.to_s);
      render :show_error
    end

  end

  private
    def switch_user_params()
      return params.require(:switch_info).permit(:task_id, :user_id);
    end
end
