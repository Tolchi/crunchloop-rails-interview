class TodoList < ApplicationRecord
  has_many :todos, dependent: :destroy

  after_create_commit do
    broadcast_prepend_to :todo_lists, target: "todo_lists", partial: "todo_lists/todo_list", locals: { todo_list: self }
  end

  validates :name, presence: true, length: { minimum: 3 }
end
