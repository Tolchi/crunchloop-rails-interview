class TodoListsController < ApplicationController
  before_action :set_todo_list, only: %i[show]
  # GET /todolists
  def index
    @todo_lists = TodoList.all
    @todo_list = TodoList.new

    respond_to :html
  end

  def show
    @todos = @todo_list.todos
    @todo = Todo.new
  end

  def create
    @todo_list = TodoList.new(todo_list_params)
    if @todo_list.save!
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:todo_lists, partial: "todo_lists/todo_list", locals: { todo_list: @todo_list })
        end
      end
    end
  rescue ActiveRecord::RecordInvalid
    redirect_to :root_path, alert: "Could not be created a todo list"
  end

  private

  def set_todo_list
    @todo_list = TodoList.includes(:todos).find(params[:id])
  end

  def todo_list_params
    params.require(:todo_list).permit(:name)
  end
end
