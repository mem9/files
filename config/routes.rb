# -*- encoding : utf-8 -*-
Fileapp::Application.routes.draw do


  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users do
    resources :uploads
  end
  resources :uploads
  root :to => 'uploads#index'


end
