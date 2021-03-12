require "./connect_db.rb"
require 'active_record'

class Todo < ActiveRecord::Base
  def self.add_task(new_todo)
    Todo.create!(
      "todo_text": new_todo[:todo_text],
      "due_date": Date.today + new_todo[:due_in_days].to_i,
      "completed": false
    )
  end

  def due_today?
    due_date == Date.today
  end

  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : @due_date
    "#{id} #{display_status} #{todo_text} #{display_date}"
  end

  def self.mark_as_complete!(todo_id)
    todo = Todo.find(todo_id)
    todo.completed = true
    todo.save
    return todo
  end

  def self.show_list
    puts Todo.all.map {|todo| todo.to_displayable_string }
  end
end
