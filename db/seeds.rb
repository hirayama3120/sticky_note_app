# ユーザの作成
user0 = User.create(name: 'Not Assigned');
user1 = User.create(name: 'User001');
user2 = User.create(name: 'User002');

# タスクの作成
Task.create(title: 'task001', description: '0001', due_date: Date.new(2020, 4, 30), user: user0);
Task.create(title: 'task002', description: '0002', due_date: Date.new(2020, 4, 30), user: user1);
Task.create(title: 'task003', description: '0003', due_date: Date.new(2020, 4, 30), user: user2);
Task.create(title: 'task004', description: '0004', due_date: Date.new(2020, 4, 30), user: user1);