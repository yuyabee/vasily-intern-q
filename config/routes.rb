Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get :wifi_spots, to: 'wifi_spots#index'
  root to: 'wifi_spots#index'
end
