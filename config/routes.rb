# Rails.application.routes.draw do
#   mount Shrew::Engine => Rails.configuration.shrew[:route_scope]
# end

Shrew::Engine.routes.draw do
  scope module: Shrew.route_scope do
    resources :page_views, only: [:create], defaults: { format: :json }
  end
end
