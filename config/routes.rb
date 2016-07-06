Rails.application.routes.draw do
  get 'photos' => 'photo#index'
  get 'photo_show' => 'photo/show'
  root "photo#index"

end
