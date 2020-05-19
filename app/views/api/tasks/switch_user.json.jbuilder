json.task do
  json.id(@task.id);
  json.title(@task.title);
  json.description(@task.description);
  json.due_date(@task.due_date.strftime("%Y-%m-%d %H:%M:%S"));
  json.user_id(@task.user.id);
end