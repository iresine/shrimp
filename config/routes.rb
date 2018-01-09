Rails.application.routes.draw do
  get '/', to: redirect('shrimp')

  match '/shrimp', to: 'questions#show', as: 'show', via: [:get, :post]
  match '/shrimp/answer', to: 'questions#answer', as: 'answer', via: [:get, :post]
  post '/shrimp/category', to: 'questions#show_category', as: 'show_category'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
