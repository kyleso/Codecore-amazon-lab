Rails.application.routes.draw do
  get("/", to: "welcome#home", as: :root)
  get("/home", to: "welcome#home")
  get("/about", to: "welcome#about")
  get("/contact_us", to: "welcome#contact_us")
  post("/process_contact", to: "welcome#thank_you")

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :products
      resource :session, only: [:create, :destroy]
      resources :users, only: [] do
        get :current, on: :collection
      end
    end
  end

  resources :users, only: [:new, :create]

  resource :session, only: [:new, :create, :destroy]

  resources :products do
    resources :favourites, shallow: true, only: [:create, :destroy]
    get :favourited, on: :collection
    resources :reviews, only: [:create, :destroy] do
      resources :likes, shallow: true, only: [:create, :destroy]
      resources :votes, shallow: true, only: [:create, :update, :destroy]
    end
  end

  resources :news_articles

  patch("/products/:product_id/reviews/:id/hide", to: "reviews#hide", as: :hide)
  # get('products/new', to: "products#new", as: :new_product)
  # post('/products', to: "products#create", as: :products)

  # get('/products/:id', to: 'products#show', as: :product)
  # get('/products', to: 'products#index')

  # delete('/products/:id', to: 'products#destroy')

  # get('/products/:id/edit', to: 'products#edit', as: :edit_product)
  # patch('/products/:id', to: "products#update")
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
