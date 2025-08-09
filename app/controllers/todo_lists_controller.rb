class TodoListsController < ApplicationController
  before_action :set_todo_list, only: %i[show update destroy]
  # GET /todolists
  def index
    @todo_lists = TodoList.all

    respond_to :html
  end

  def show
    @todos = @todo_list.todos
    @todo = Todo.new
  end

  # GET /todolists/new
  def new
    @todo_list = TodoList.new

    respond_to :html
  end

  def create
    @todo_list = TodoList.new(todo_list_params)
  end

  private

  def set_todo_list
    @todo_list = TodoList.includes(:todos).find(params[:id])
  end

  def todo_list_params
    params.permit(:name)
  end
end
