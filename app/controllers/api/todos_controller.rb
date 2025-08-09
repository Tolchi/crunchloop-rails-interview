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

    def destroy
      @todo.destroy!
      head :no_content
    end

    def complete
      @todo.update(completed: true)
      render json: { message: 'Todo completed' }, status: :ok
    end

    def complete_all
      todos_ids = @todo_list.todos.pluck(:id)
      CompleteAllJob.perform_later(todos_ids)
      render json: { message: 'Complete All todos job was enqueued. A few moments later, the job will be done.' }, status: :ok
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
