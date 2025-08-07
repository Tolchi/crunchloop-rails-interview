module Api
  class TodosController < ApplicationController
    before_action :set_todo_list
    before_action :set_todo, only: %i[update destroy complete]

    def create
      @todo = Todo.new(todo_params)
      if @todo.save
        render json: { message: 'Todo was created successfully' }, status: :ok
      else
        render json: @todo.errors, status: :unprocessable_entity
      end
    end

    def update
      respond_to :json
    end

    def destroy
      @todo.destroy!
      head :no_content
    end

    def complete
      if @todo.update(completed: true)
        render json: { message: 'Todo completed' }, status: :ok
      else
        render json: @todo.errors, status: :unprocessable_entity
      end
    end

    private

    def set_todo_list
      @todo_list = TodoList.includes(:todos).find(params[:todo_list_id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Todo list not found' }, status: :not_found
    end

    def set_todo
      @todo = @todo_list.todos.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Todo not found' }, status: :not_found
    end

    def todo_params
      params.permit(:description, :completed, :todo_list_id)
    end
  end
end
