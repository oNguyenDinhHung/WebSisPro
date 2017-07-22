Rails.application.routes.draw do
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'test_page#home'    
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :hocphans do
    collection do      
      post :import
    end
  end
  resources :lophocs do
      collection do        
        post :import
      end
    end
  resources :dangkihocphans,:chuongtrinhdaotaos
  resources :khoaviens do
    collection do
        post :import
      end
    end

  resources :lopsinhviens
  resources :sinhviens do
      collection do
        post :import
        get :thoikhoabieu                              
        get :svdkh               
      end
    end
  resources :dangkilophocs do
      collection do
        post :import        
      end
    end
  resources :giaoviens
  resources :hockis do
    collection do
      post :modangki
    end
  end
end
