Rails.application.routes.draw do
  root 'dashboard#index'
  namespace :api do
    resources :annotation_requests, :only => [:show, :create]
  end
  post '/_scale_callback' => 'callback#callback', as: :scale_callback
end
