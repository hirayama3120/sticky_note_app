require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  # ユーザを指定しないタスクは保存できない。
  test "Not assinged task should fail to create" do
    new_task = Task.new(title: "test001", description: "hoge", due_date: Date.new(2020,5,1));
    assert_raises(ActiveRecord::RecordInvalid) do
      new_task.save!
    end
  end

  # ユーザを指定すると保存できる。
  test "Assinged task should success to create" do
    user = users(:notassigned);
    new_task = Task.new(title: "test001", description: "hoge", due_date: Date.new(2020,5,1), user: user);
    assert_nothing_raised do
      new_task.save!
    end
  end

  # アサイン先を変更できる。
  test "task's owner can be changed to another user" do
    bob = users(:bob);
    assert_difference('bob.tasks.count') do 
      target = tasks(:task2);
      target.user = bob;
      target.save!;
      bob.tasks.reload;
    end
  end
end
