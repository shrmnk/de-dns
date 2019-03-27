Rails.application.routes.draw do
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             }

  scope :api, defaults: { format: :json } do
    resources :hostnames, only: [:index, :show], param: :name, constraints: { name: /[0-z\.]+/ }
  end
end
