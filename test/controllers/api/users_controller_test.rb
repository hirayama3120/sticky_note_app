require 'test_helper'

class Api::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get user_task_list.json" do
    # jsonフォーマット指定でGETリクエストを投げます。
    get api_users_user_task_list_url(:json)

    # 200OKが返ってくるはず。
    assert_response :success

    # Boby部をJSONデータに変換
    json_data = ActiveSupport::JSON.decode(@response.body);

    # usersの配列の長さは3のはず(fixtureで3人作っていれば)
    assert_equal(3, json_data['users'].length);

  end

  test "should create user" do
    before_user_count = User.all().length;

    post api_users_create_user_url(:json)

    assert_response :success

    json_data = ActiveSupport::JSON.decode(@response.body);
    after_user_count = User.all().length;
    new_user_count = User.where('name like ?', 'New User%').count

    assert_equal(before_user_count + 1, after_user_count);
    assert_equal('New User' + new_user_count.to_s, json_data['name'])
  end
end
