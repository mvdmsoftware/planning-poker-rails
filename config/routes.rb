Rails.application.routes.draw do
   root 'home#index'
   
   get 'home/index'
   
   get 'room/new', to: 'rooms#new', as: 'new_room'
   get 'room/join/:room_identifier', to: 'rooms#join', as: 'join_room'
   get 'room/:room_identifier', to: 'rooms#show', as: 'show_room'
   post 'room/:room_identifier/estimate/:value', to: 'rooms#estimate', as: 'estimate'
   post 'room/:room_identifier/hide', to: 'rooms#hide', as: 'hide_room'
   post 'room/:room_identifier/reveal', to: 'rooms#reveal', as: 'reveal_room'
   post 'room/:room_identifier/reset', to: 'rooms#reset', as: 'reset_room'
end
