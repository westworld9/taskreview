Rails.application.routes.draw do
  
  root to: 'tasks#index'
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  resources :tasks do 
    resources :reviews, except: [:index, :show]
  end
  resources :users, only:[:show, :index]
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
