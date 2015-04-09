Rails.application.routes.draw do

  get 'workflows/set'

  get 'workflows/update'
  
  get 'projects/search'

  ActiveAdmin.routes(self) 

  get '/users/sign_out' => 'devise/sessions#destroy'
  get 'admin/' => 'admin#index', as: 'admin'
  devise_for :users
  resources :users
  resources :projects 
   resources :documents, except: [:index, :update] do
  resources :versions, only: [:destroy] do
    member do
      get :diff, to: 'versions#diff'
      patch :rollback, to: 'versions#rollback'
    end
  end
end

  resources :tasks
  
  resources :roles

  resources :document_templates

  #get 'assigntaskindex' => 'projects#createtask'
  get 'projects/:id/member' => 'projects#member', as: :member
  post 'projects/:id/member' => 'projects#member'
  get 'projects/:id/assigntask' => 'projects#assigntaskindex', as: :assigntaskindex
  get 'projects/:id/tasks' => 'projects#tasks', as: :tasklist
  get 'projects/:id/edittask/:taskid' => 'projects#edittask', as: :edittask
  post 'projects/:id/updatetask' => 'projects#updatetask', as: :updatetask
  post 'projects/:id/createtask' => 'projects#createtask', as: :createtask
  get 'projects/:id/member/remove_member' => 'projects#remove_member', as: :remove_member
  post 'projects/:id/respondtask/' => 'projects#respondTask'

  get 'projects/status/:id' => 'projects#status'

  get 'projects/:id/documents' => 'documents#index'
  get 'documents/new/:proj_id/:doctmpl_id' => 'documents#new', as: :newdocument
  get 'documents/delete/:proj_id/:id' => 'documents#destroy'
  get 'documents/edit/:proj_id/:id/:doctmpl_id' => 'documents#edit', as: :editdocument
  post 'documents/edit/:proj_id/:id/:doctmpl_id' => 'documents#edit'
  patch 'documents/update/:proj_id/:id/:doctmpl_id' => 'documents#update'

  get 'tasks/submit/:proj_id/:id' => 'tasks#submitForApproval'

  get 'templates/workflows/set/:doctmpl_id' => 'workflows#set'
  post 'templates/workflows/update/:doctmpl_id' => 'workflows#update', as: :workflowupdate

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
    root 'projects#index'

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
