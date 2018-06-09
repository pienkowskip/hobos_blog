Rails.application.routes.draw do
  root to: 'front/posts#index'

  namespace :admin do
    root to: 'admin_site#index'

    get 'users/:id/reset_password_from_email/:key' => 'users#reset_password', as: 'reset_password_from_email'
    get 'users/:id/accept_invitation_from_email/:key' => 'users#accept_invitation', :as => 'accept_invitation_from_email'
    get 'users/:id/activate_from_email/:key' => 'users#activate', :as => 'activate_from_email'

    resources :users, :only => [] do
      collection do
        get 'first'
      end
      member do
        put 'accept_invitation', :action => 'do_accept_invitation'
        get 'accept_invitation'
        put 'reset_password', :action => 'do_reset_password'
        get 'reset_password'
      end
    end
  end

  scope :admin do
    get 'users/:id/account' => 'admin/users#account', :as => 'account_user'
    post 'login' => 'admin/users#login', :as => 'user_login_post'
    get 'login' => 'admin/users#login', :as => 'user_login'
    get 'logout' => 'admin/users#logout', :as => 'user_logout'
    get 'forgot_password' => 'admin/users#forgot_password', :as => 'user_forgot_password'
    post 'forgot_password' => 'admin/users#forgot_password', :as => 'user_forgot_password_post'
  end

  scope module: 'front' do
    # get 'home' => 'static#home', as: 'home_page'
    get 'about' => 'static#about', as: 'about_page'
    get 'contact' => 'static#contact', as: 'contact_page'
    resources :posts, only: [:index, :show] do
      resources :comments, only: [:create]
      collection do
        get :search
      end
      member do
        post :comment
        get :comment, to: redirect(path: '/posts/%{id}')
      end
    end
  end
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
