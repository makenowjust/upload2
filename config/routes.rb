# frozen_string_literal: true

Rails.application.routes.draw do
  root 'files#index'
  resources :files, only: %i[show create destroy], as: :file_infos
  resources :download, only: %i[show]
end
