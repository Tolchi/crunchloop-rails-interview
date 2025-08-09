require 'rails_helper'

RSpec.describe "Todos", type: :request do
  def json
    JSON.parse(response.body)
  end

  # CREATE
  describe 'POST /api/todolist/:todo_list_id/todos/' do
    let!(:todo_list) { create(:todo_list) }

    context 'with valid params' do
      let!(:valid_params) { { description: 'Descriptiion', completed: false, todo_list_id: todo_list.id}}


      it 'creates a new todo' do
       expect {
         post "/api/todolists/#{todo_list.id}/todos", params: valid_params
       }.to change(Todo, :count).by(1)
      end

      it 'returns a succesful response' do
        post "/api/todolists/#{todo_list.id}/todos", params: valid_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      let!(:invalid_params) { { description: nil, completed: nil } }

      it 'returns unprocessable entity response' do
        post "/api/todolists/#{todo_list.id}/todos", params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error message' do
        post "/api/todolists/#{todo_list.id}/todos", params: invalid_params
        expect(response.body).to include("can't be blank")
      end
    end
  end

  # DELETE
  describe 'delete /api/todolists/:todo_list_id/todos/:id' do
    context 'with existing todo list' do
      let!(:todo_list) { create(:todo_list) }

      context 'with existing todo' do
        let!(:todo) { create(:todo, todo_list: todo_list) }

        it 'returns no content status' do
          delete "/api/todolists/#{todo_list.id}/todos/#{todo.id}"
          expect(response).to have_http_status(:no_content)
        end

        it 'deletes a todo' do
          expect {
            delete "/api/todolists/#{todo_list.id}/todos/#{todo.id}"
          }.to change(Todo, :count).by(-1)
        end
      end

      context 'with inexisting todo' do
        it 'returns unprocessable entity' do
          delete "/api/todolists/#{todo_list.id}/todos/999"
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context 'with non exisiting todo list' do
      it 'returns unprocessable entity' do
        delete '/api/todolists/999/todos/1'
        expect(response).to have_http_status(:not_found)
      end

      it 'returns error message' do
        delete '/api/todolists/999/todos/1'
        expect(json['errors']).to include('Todo list not found')
      end
    end
  end

  # COMPLETE
  describe 'put /api/todolists/:todo_list_id/todos/:id/complete' do
    context 'with existing todo list' do
      let!(:todo_list) { create(:todo_list) }
      context 'with exising todo' do
        let!(:todo) { create(:todo, todo_list: todo_list) }

        before { put "/api/todolists/#{todo_list.id}/todos/#{todo.id}/complete" }

        it 'returns ok' do
          expect(response).to have_http_status(:ok)
        end

        it 'returns todo complete field updated' do
          todo.reload
          expect(todo.completed).to eq(true)
        end
      end

      context 'with non existing todo' do
        it 'returns not found' do
          put "/api/todolists/#{todo_list.id}/todos/999/complete"
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context 'with non existing todo list' do
      it 'returns not found' do
        put '/api/todolists/999/todos/1/complete'
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'Complete all todos' do
    let!(:todo_list) { create(:todo_list) }
    let!(:todos) { create_list(:todo, 3, todo_list: todo_list) }
    let(:todo_ids) { todos.pluck(:id) }

    it 'enqueue CompleteAllJob que' do
      expect {
        put "/api/todolists/#{todo_list.id}/todos/complete_all"
      }.to have_enqueued_job(CompleteAllJob).with(todo_ids)
    end

    it 'returns succesful enqueue message' do
      put "/api/todolists/#{todo_list.id}/todos/complete_all"
      expect(response).to have_http_status(:ok)
    end
  end
end
