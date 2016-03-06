Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Articles
  put 'article/edit', to: 'article#edit_single_article'
  get 'article/new', to: 'article#request_new_article'
  get 'article/:idhsh/edit', to: 'article#request_edit_article'
  get 'article/:idhsh', to: 'article#show_single_article'
  get 'article', to: 'article#show_all_articles'
  post 'article', to: 'article#create_new_article'

  # User Authentication
  devise_for :shell_users, controllers: {
    sessions: "shell_users/sessions",
    registrations: "shell_users/registrations",
  }, path: 'bbs/local/shell/'

  # Administration
  namespace :admin do
    get :shell, to: 'shell#index'
  end

  # Forum Account
  namespace :bbs do
    get 'user/new', to: 'forum_account#request_new_account'
    post 'user/new', to: 'forum_account#create_new_account'
    namespace :member do
      get ':account_idhsh', to: 'shell#show_usr_homepage'
    end
    namespace :thread do
      get ':thread_idhsh', to: 'shell#show_thread'
    end
  end

  # BBS LocalUser
  get 'bbs/local', to: 'web_shell#local_user'

  # You can have the root of your site routed with "root"
  root 'web_shell#root_index'

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
