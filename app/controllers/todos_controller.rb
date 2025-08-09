class TodosController < ApplicationController
  before_action :set_todo_list
  before_action :set_todo, only: :complete

  def create
    @todo = @todo_list.todos.new(todo_params)
    if @todo.save!
      respond_to do |format|
        format.html { redirect_to @todo_list }
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:todos, partial: "todos/todo", locals: { todo: @todo })
        end
      end
    end
  rescue ActiveRecord::RecordInvalid
    redirect_to :root_path, alert: "Could not be created a todo"
  end

  def complete
    @todo.update(completed: !@todo.completed)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.append(:todos, partial: "todos/complete", locals: { todo: @todo })
      end
    end
  end

  private

  def set_todo_list
    @todo_list = TodoList.includes(:todos).find(params[:todo_list_id])
  end

  def set_todo
	flash.now[:notice] = "Todo was updated succesfully"
    @todo = @todo_list.todos.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:description, :completed, :todo_list_id)
  end
end
