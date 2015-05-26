Rails.application.routes.draw do

  #######################################
  # =================================== #
  #      Routes for shaohua 5.0.0       #
  # =================================== #
  # ├─ Home                             #
  # ├─ About                            #
  # ├─ Articles                         #
  # ├─ Periodicals                      #
  # ├─ Users                            #
  # └─ Administrations                  #
  #######################################

  #######################################
  # =================================== #
  #              Home Page              #
  # =================================== #
  #######################################
  root 'web_shell#global_web_homepage'
   get 'web_shell/global_web_homepage'
   get 'web_shell/404', to: 'web_shell#r404'
   get 'web_shell/422', to: 'web_shell#r422'
   get 'web_shell/500', to: 'web_shell#r500'
   get 'web_shell/raw', to: 'web_shell#ieraw'

  #######################################
  # =================================== #
  #             About Page              #
  # =================================== #
  #######################################
   get 'about', to: 'web_shell#about'

  #######################################
  # =================================== #
  #              Articles               #
  # =================================== #
  #######################################
  # ----------------------------------- #
  #            Manage Article           #
  # ----------------------------------- #
  # Require                 All Article #
   get 'article', to: 'articles#show_all_article'
  # Require                 New Article #
   get 'article/new', to: 'articles#new_article'
  # Require                Edit Article #
   get 'article/edit/:hash', to: 'articles#edit_article'
  # Require                Show Article #
   get 'article/:hash', to: 'articles#show_article'
  # Create                  New Article #
  post 'article/create', to: 'articles#create_article'
  # Update              Existed Article #
   put 'article/update', to: 'articles#update_article'
  # ----------------------------------- #
  #               Top Article           #
  # ----------------------------------- #
  # Require Tops        Existed Article #
   get 'article/top/:hash', to: 'articles#top_of_article'
  # Sumbit a Top        Existed Article #
  post 'article/top', to: 'articles#top_an_article'
  # ----------------------------------- #
  #           Comment Article           #
  # ----------------------------------- #
  # Require Comments    Existed Article #
   get 'article/comment/:hash', to: 'articles#top_of_article'
  # Sumbit a Comment    Existed Article #
  post 'article/comment', to: 'articles#top_an_article'
  # ----------------------------------- #
  #               Tag Article           #
  # ----------------------------------- #
  # Require Tags        Existed Article #
   get 'article/tag/:hash', to: 'articles#tag_of_article'
  # Sumbit a Tag        Existed Article #
  post 'article/tag', to: 'articles#tag_an_article'

  #######################################
  # =================================== #
  #             Periodicals             #
  # =================================== #
  #######################################
  # ----------------------------------- #
  #            Manage Periodicals       #
  # ----------------------------------- #
  # Require                    Designer #
   get 'periodical/design',to: 'periodicals#app_designer'
  # Require              All Periodical #
   get 'periodical',to: 'periodicals#show_all_periodical'
  # Require              New Periodical #
   get 'periodical/new',to: 'periodicals#new_periodical'
  # Require            Edit Perdiodical #
   get 'periodical/edit/:hash', to: 'periodicals#edit_article'
  # Require          Existed Periodical #
   get 'periodical/:hash',to: 'periodicals#show_periodical'
  # Create               New Periodical #
  post 'periodical/create',to: 'periodicals#create_periodical'
  # Update           Existed Periodical #
   put 'periodical/update', to: 'periodicals#update_article'

  #######################################
  # =================================== #
  #                Users                #
  # =================================== #
  #######################################
  # ----------------------------------- #
  #            Manage Users             #
  # ----------------------------------- #
  # Require                       Login #
   get 'bbs/login', to: 'web_accounts#login_require'
  # Require                      Signup #
   get 'bbs/signup', to: 'web_accounts#signup_require'
  # Sumbit                        Login #
  post 'bbs/login', to: 'web_accounts#login_check'
  # Sumbit                       Signup #
  post 'bbs/signup', to: 'web_accounts#signup_do'
  # ----------------------------------- #
  #              Show Users             #
  # ----------------------------------- #
  # Require                         BBS #
   get 'bbs', to: 'web_accounts#self_home_page'
  # Require                Existed User #
   get 'bbs/:hash', to: 'web_accounts#usr_home_page'

  #######################################
  # =================================== #
  #            END OF ROUTES            #
  # =================================== #
  #######################################

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
