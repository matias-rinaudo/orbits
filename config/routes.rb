Rails.application.routes.draw do
  root "home#index"
  
  resources :musics do
    collection do
      get :search_in_rapid_api
      post :save_music_from_rapid_api
    end
  end
end
