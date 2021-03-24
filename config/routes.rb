Rails.application.routes.draw do
  root "employees#index"
  
  resources :employees do
    collection { post :import }
  end
   
end
