Rails.application.routes.draw do

  # Homepage of the Website
  # get 'web_shell/index'#!DEBUG-ONLY!#
  
  # Aboutpage of the Website
  get 'about', to: 'web_shell#about'

  # Articles
  # Show Authors article
  get 'article/author/:hash', to: 'articles#show_author'
  # New Article
  get 'article/new', to: 'articles#new_article'
  # Create Article
  post 'article/create', to: 'articles#create_article'
  # Edit Article
  get 'article/edit', to: 'articles#edit_article'
  # Update Article
  put 'article/update', to: 'articles#update_article'
  # Show Article
  get 'article/:hash', to: 'articles#show_article'
  # Show Article List
  get 'article', to: 'articles#show_all_article'

  # Login
  post 'login', to: 'web_global#usrlogin'
  # Signup
  get 'debugadmin/signup',to: 'web_admin#sudo_sign_up_debug' #!DEBUG-ONLY!#

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'web_shell#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
