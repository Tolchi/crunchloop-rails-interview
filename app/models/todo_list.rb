class TodoList < ApplicationRecord
  has_many :todos, dependent: :destroy
end
