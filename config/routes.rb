Rails.application.routes.draw do
  get('/home', to: "welcome#home")
  get('/about', to: "welcome#about")
  get('/contact_us', to: "welcome#contact_us")
  post("/contact_us", to: "welcome#thank_you")

  get('products/new', to: "products#new", as: :new_product)
  post('/products', to: "products#create", as: :products)

  get('/products/:id', to: 'products#show', as: :product)
  get('/products', to: 'products#index')

  delete('/products/:id', to: 'products#destroy')

  get('/products/:id/edit', to: 'products#edit', as: :edit_product)
  patch('/products/:id', to: "products#update")
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
