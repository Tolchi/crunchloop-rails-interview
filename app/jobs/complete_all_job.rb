class CompleteAllJob < ApplicationJob
  queue_as :complete_all

  def perform(todos_ids)
    todos = Todo.where(id: todos_ids)
    todos.each do |t|
      t.update!(completed: true)
    end
  end
end
