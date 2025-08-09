Rails.application.routes.draw do
  namespace :api do
    resources :todo_lists, only: %i[index], path: :todolists do
      resources :todos, only: %i[create update destroy] do
        member do
          put 'complete'
        end
        collection do
          put 'complete_all'
        end
      end
    end
  end

  resources :todo_lists, only: %i[create show], path: :todolists do
    resources :todos, only: [:create] do
      member do
        put 'complete'
      end
    end
  end

  root to: 'todo_lists#index'
end
