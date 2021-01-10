Rails.application.routes.draw do
   root 'home#index'
   
   get 'home/index'
   
   get 'room/new', to: 'rooms#new', as: 'new_room'
   get 'room/:unique_identifier', to: 'rooms#show', as: 'show_room'
   post 'room/:room/estimate/:value', to: 'rooms#estimate', as: 'estimate'
end
