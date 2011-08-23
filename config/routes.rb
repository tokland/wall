Wall::Application.routes.draw do
  root :to => "live_classes#index"
  resource :session, :controller => 'sessions'
  resources :live_classes do
    resources :notes do
      post "sync", :on => :collection
    end
  end
end
