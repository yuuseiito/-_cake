Rails.application.routes.draw do
  
  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

  
  scope module: :public do
    resources :items
    delete 'cart_items/destroy_all' =>'cart_items#destroy_all'
    resources :cart_items
    get '/customers/mypage' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    get 'customers/check' => 'customers#check'
    patch 'customers/withdrwal' => 'customers#withdrwal'
    patch 'customers/update' => 'customers#update'
    get '/about' => 'homes#about'
    root to: 'homes#top'
    get 'orders/conplation' => 'orders#conplation'
    resources :orders
    post 'orders/confirmation' => 'orders#confirmation'
  end
  
  namespace :admin do
    resources :items
    resources :customers
    get 'homes' => 'homes#top'
    get 'orders/:id' => 'order#show',as:"order"
  end
  
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
