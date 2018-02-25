# == Route Map
#
#                    Prefix Verb   URI Pattern                        Controller#Action
#         new_admin_session GET    /admins/sign_in(.:format)          admins/sessions#new
#             admin_session POST   /admins/sign_in(.:format)          admins/sessions#create
#     destroy_admin_session DELETE /admins/sign_out(.:format)         admins/sessions#destroy
#        new_admin_password GET    /admins/password/new(.:format)     admins/passwords#new
#       edit_admin_password GET    /admins/password/edit(.:format)    admins/passwords#edit
#            admin_password PATCH  /admins/password(.:format)         admins/passwords#update
#                           PUT    /admins/password(.:format)         admins/passwords#update
#                           POST   /admins/password(.:format)         admins/passwords#create
# cancel_admin_registration GET    /admins/cancel(.:format)           admins/registrations#cancel
#    new_admin_registration GET    /admins/sign_up(.:format)          admins/registrations#new
#   edit_admin_registration GET    /admins/edit(.:format)             admins/registrations#edit
#        admin_registration PATCH  /admins(.:format)                  admins/registrations#update
#                           PUT    /admins(.:format)                  admins/registrations#update
#                           DELETE /admins(.:format)                  admins/registrations#destroy
#                           POST   /admins(.:format)                  admins/registrations#create
#    new_admin_confirmation GET    /admins/confirmation/new(.:format) admins/confirmations#new
#        admin_confirmation GET    /admins/confirmation(.:format)     admins/confirmations#show
#                           POST   /admins/confirmation(.:format)     admins/confirmations#create
#          new_admin_unlock GET    /admins/unlock/new(.:format)       admins/unlocks#new
#              admin_unlock GET    /admins/unlock(.:format)           admins/unlocks#show
#                           POST   /admins/unlock(.:format)           admins/unlocks#create
#                    admins GET    /admins(.:format)                  admins#index
#                     admin GET    /admins/:id(.:format)              admins#show
#                           DELETE /admins/:id(.:format)              admins#destroy
#          new_user_session GET    /users/sign_in(.:format)           users/sessions#new
#              user_session POST   /users/sign_in(.:format)           users/sessions#create
#      destroy_user_session DELETE /users/sign_out(.:format)          users/sessions#destroy
#         new_user_password GET    /users/password/new(.:format)      users/passwords#new
#        edit_user_password GET    /users/password/edit(.:format)     users/passwords#edit
#             user_password PATCH  /users/password(.:format)          users/passwords#update
#                           PUT    /users/password(.:format)          users/passwords#update
#                           POST   /users/password(.:format)          users/passwords#create
#  cancel_user_registration GET    /users/cancel(.:format)            users/registrations#cancel
#     new_user_registration GET    /users/sign_up(.:format)           users/registrations#new
#    edit_user_registration GET    /users/edit(.:format)              users/registrations#edit
#         user_registration PATCH  /users(.:format)                   users/registrations#update
#                           PUT    /users(.:format)                   users/registrations#update
#                           DELETE /users(.:format)                   users/registrations#destroy
#                           POST   /users(.:format)                   users/registrations#create
#     new_user_confirmation GET    /users/confirmation/new(.:format)  users/confirmations#new
#         user_confirmation GET    /users/confirmation(.:format)      users/confirmations#show
#                           POST   /users/confirmation(.:format)      users/confirmations#create
#           new_user_unlock GET    /users/unlock/new(.:format)        users/unlocks#new
#               user_unlock GET    /users/unlock(.:format)            users/unlocks#show
#                           POST   /users/unlock(.:format)            users/unlocks#create
#                users_root GET    /users(.:format)                   users#index
#              search_users POST   /users/search(.:format)            users#index
#            following_user GET    /users/:id/following(.:format)     users#following
#                     users GET    /users(.:format)                   users#index
#                      user GET    /users/:id(.:format)               users#show
#                           DELETE /users/:id(.:format)               users#destroy
#                      root GET    /                                  static_pages#home
#             relationships POST   /relationships(.:format)           relationships#create
#              relationship DELETE /relationships/:id(.:format)       relationships#destroy
#                  sponsors GET    /sponsors(.:format)                sponsors#index
#                           POST   /sponsors(.:format)                sponsors#create
#               new_sponsor GET    /sponsors/new(.:format)            sponsors#new
#              edit_sponsor GET    /sponsors/:id/edit(.:format)       sponsors#edit
#                   sponsor GET    /sponsors/:id(.:format)            sponsors#show
#                           PATCH  /sponsors/:id(.:format)            sponsors#update
#                           PUT    /sponsors/:id(.:format)            sponsors#update
#                           DELETE /sponsors/:id(.:format)            sponsors#destroy
#             forhires_root GET    /forhires(.:format)                forhires#index
#           search_forhires POST   /forhires/search(.:format)         forhires#index
#                  forhires GET    /forhires(.:format)                forhires#index
#                           POST   /forhires(.:format)                forhires#create
#               new_forhire GET    /forhires/new(.:format)            forhires#new
#              edit_forhire GET    /forhires/:id/edit(.:format)       forhires#edit
#                   forhire GET    /forhires/:id(.:format)            forhires#show
#                           PATCH  /forhires/:id(.:format)            forhires#update
#                           PUT    /forhires/:id(.:format)            forhires#update
#                           DELETE /forhires/:id(.:format)            forhires#destroy
#             projects_root GET    /projects(.:format)                projects#index
#           search_projects POST   /projects/search(.:format)         projects#index
#                  projects GET    /projects(.:format)                projects#index
#                           POST   /projects(.:format)                projects#create
#               new_project GET    /projects/new(.:format)            projects#new
#              edit_project GET    /projects/:id/edit(.:format)       projects#edit
#                   project GET    /projects/:id(.:format)            projects#show
#                           PATCH  /projects/:id(.:format)            projects#update
#                           PUT    /projects/:id(.:format)            projects#update
#                           DELETE /projects/:id(.:format)            projects#destroy
#                   opening GET    /openings/:id(.:format)            openings#show
# 

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  # BEGIN: admin section
  devise_for :admins,
             controllers: { registrations: 'admins/registrations',
                            sessions: 'admins/sessions',
                            passwords: 'admins/passwords',
                            confirmations: 'admins/confirmations',
                            unlocks: 'admins/unlocks' }
  resources :admins, only: [:show, :index, :destroy]
  # END: admin section

  # BEGIN: user section
  devise_for :users,
             controllers: { registrations: 'users/registrations',
                            sessions: 'users/sessions',
                            passwords: 'users/passwords',
                            confirmations: 'users/confirmations',
                            unlocks: 'users/unlocks' }
  resources :users, only: [:show, :index, :destroy] do
    root to: 'users#index'
    collection { post :search, to: 'users#index' }
    member do
      get :following
    end
  end
  # END: user section

  # BEGIN: static pages
  root 'static_pages#home'
  # END: static pages

  resources :relationships, only: [:create, :destroy]

  resources :sponsors, only: [:show, :index, :create, :new, :update, :edit, :destroy]

  # BEGIN: forhire section
  resources :forhires, only: [:show, :index, :create, :new, :update, :edit, :destroy] do
    root to: 'forhires#index'
    collection { post :search, to: 'forhires#index' }
  end
  # END: forhire section

  # BEGIN: project section
  resources :projects, only: [:show, :index, :create, :new, :update, :edit, :destroy] do
    root to: 'projects#index'
    collection { post :search, to: 'projects#index' }
  end
  # END: project section

  # BEGIN: opening section
  resources :openings, only: [:show]
  # END: opening section
end
# rubocop:enable Metrics/BlockLength
