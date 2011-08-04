Orangerie::Application.routes.draw do

  
  # root of the page.
  root :to => "pages#home"
  
  # FIXME for devise installation
  devise_for :admins
  devise_for :users
  
  resources :connections, :posts, :comments, :flags, :chatmessages, :searches, :guestbook_messages, :notifications

  # routes for the guestbook.
  get 'guestbook/' => 'guestbook_messages#index'
  get 'guestbook/new' => 'guestbook_messages#new'
  get 'guestbook/:id' => 'guestbook_messages#show'
  
  # explicit german routes for guestbook
  # %C3A4 is the unicode for 'ä'
  get 'g%C3%A4stebuch/' => 'guestbook_messages#index'
  get 'g%C3%A4stebuch/new' => 'guestbook_messages#new'
  get 'g%C3%A4stebuch/:id' => 'guestbook_messages#show'
  
  
  
  # chat only for the trusted users
  get 'chat/trusted' =>  'chatmessages#show'
  
  # FIXME: really ugly.. but not sure if there is a better way to do this...
  resources :photos, :posts, :albums, :pages do 
    resources :comments
  end
  
  # User resources
  resources :users do
    get :trusted
    resources :connections
    resources :messages
    resources :photos
    resources :albums do
      resources :photos do
        # makes the the photo the avatar of the user.
        put '/make_avatar' => 'photos#make_avatar' 
      end
    
    end
    resources :posts
    member do
      get :infos
      get :friends
      get :fotos
      get :livestream
      get :wall
    end
  end
  
  # Resources for messages
  resources :messages do
    collection do
      get :sent
      get :trash
      get :recipients
    end
    member do
      get :reply
      put :undestroy
    end
  end
  
  # Event resources
  resources :events do
    resources :comments
    resources :reservations
    post "invite_friends" => "invites#invite_friends"
  end
  get "events/reviews" => "events#reviews"
  
  # generates the 'admin' namespace.
  # creates URLs like "admin/messages"
  namespace "admin" do
    resources :categories do
      member do
        put :move_up
        put :move_down
      end
    end
    resources :pages do
      member do
        put :move_up
        put :move_down
      end
      resources :page_photos
    end
    resources :events do
      resources :event_photos
      resources :reservations do
        collection do 
          get :printview
        end
      end
    end
    resources :messages, :comments, :searches, :flags, :series, :guestbookmessages
  end
  
  # FIXME: change this route
  get "/admin/" => "admin/pages#home"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
