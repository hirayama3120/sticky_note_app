require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "New User should not have any tasks" do
    user = User.new(name: "hoge hoge");

    assert_nothing_raised do
      user.save!;
    end

    assert_equal(0, user.tasks.count);

  end

  test "Task owner can be changed" do
    bob = users(:bob);
    notassigned = users(:notassigned);
    notassigned_task = notassigned.tasks[0];

    bob.tasks.push(notassigned_task);

    assert_nothing_raised do
      bob.save!;
      notassigned.tasks.reload;
    end

    assert_equal(1, bob.tasks.length);
    assert_equal(0, notassigned.tasks.length);

  end
end
