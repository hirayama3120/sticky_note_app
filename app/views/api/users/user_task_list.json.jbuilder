json.users @users do | user |
  json.id(user.id);
  json.name(user.name);
  json.tasks do
    user.tasks.each do | task |
      json.set! task.id do
        json.id(task.id);
        json.title(task.title);
        json.description(task.description);
        json.due_date(task.due_date.strftime("%Y-%m-%d"));
      end
    end
  end
end