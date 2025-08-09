class Todo < ApplicationRecord
  belongs_to :todo_list
  scope :completed, -> { where(completed: true)}
  scope :incompleted, -> { where(completed: false)}

  after_create_commit do
    broadcast_prepend_to todo_list, target: "todos", partial: "todos/todo", locals: { todo: self }
  end

  validates :description, presence: true
end
