require 'test_helper'

class Api::TasksControllerTest < ActionDispatch::IntegrationTest
  # 正常パターン
  test "should success to switch user" do
    notassigned = users(:notassigned);
    alice = users(:alice);
    task1 = notassigned.tasks[0];

    # aliceのタスクが増えるはず。
    assert_difference 'alice.tasks.count' do
      # リクエスト投げてみる。
      put(api_tasks_switch_user_url(:json), params: { switch_info: { task_id: task1.id, user_id: alice.id } });

      # 200OKのはず
      assert_response :success

      # 念のためリロード
      alice.tasks.reload();
      notassigned.tasks.reload();

    end

    # レスポンスから、JSONデータを取得
    json_data = ActiveSupport::JSON.decode(@response.body);

    # タスクデータのユーザIDがaliceのIDになるはず。
    assert_equal(alice.id, json_data['task']['user_id']);

    # notassignedさんのタスクが0個になるはず。
    assert_equal(0, notassigned.tasks.count);

  end

  # 存在しないユーザに切り替えるとエラーになるはず。
  test "should fail to swith user if user is not exist" do
    # 新しいユーザを作る。が、保存しない。
    new_user = User.new(name: "Bab");

    # タスクデータのインスタンスを取得
    task2 = tasks(:task2);

    # 保存してないユーザに割り当ててみよう。
    put(api_tasks_switch_user_url(:json), params: { switch_info: { taks_id: task2.id, user_id: new_user.id } });

    # 一応200OK。
    assert_response :success

    json_data = ActiveSupport::JSON.decode(@response.body);

    # エラー情報が返されるはず。
    assert(json_data['errors'].count > 0);

  end

end
