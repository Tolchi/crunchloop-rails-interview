class TodosController < ApplicationController
  before_action :set_todo_list
  before_action :set_todo, only: %i[show destroy update complete]

  def show
  end

  def create
    @todo = @todo_list.todos.new(todo_params)
    if @todo.save
      respond_to do |format|
        format.html { redirect_to @todo_list }
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:todos, partial: "todos/todo", locals: { todo: @todo })
        end
      end
    else
      render :new
    end
  end

  def new
  end

  def destroy
  end

  def update
    if @todo.update(todo_params)
      respond_to do |format|
        format.html { redirect_to @todo_list }
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:todos, partial: "todos/todo", locals: { todo: @todo })
        end
      end
    else
      render :edit
    end
  end

  def edit
  end

  def complete
    @todo.update(completed: true)
    respond_to do |format|
      format.turbo_stream { render partial: 'todos/todo', locals: { todo: @todo } }
    end
  end

  private

  def set_todo_list
    @todo_list = TodoList.includes(:todos).find(params[:todo_list_id])
  end

  def set_todo
    @todo = @todo_list.todos.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:description, :completed, :todo_list_id)
  end
end
