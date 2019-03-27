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
    resources :zones, only: [:index, :show], param: :name, constraints: { name: /[0-z\.]+/ } do
      resources :hostnames, only: [:create]
    end

    resources :cloudflare_accounts, only: [:index, :show, :create] do
      resources :zones, only: [:create, :new]
    end

  end

  get '*path', to: "application#fallback_index_html", constraints: ->(request) do
    !request.xhr? && request.format.html?
  end
end
