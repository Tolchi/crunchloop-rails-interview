Rails.application.routes.draw do
  namespace :api do
    resources :todo_lists, only: %i[index], path: :todolists do
      resources :todos, only: %i[create update destroy] do
        member do
          put 'complete'
        end
      end
    end
  end

  resources :todo_lists, only: %i[index new], path: :todolists
end
