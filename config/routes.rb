# Rails.application.routes.draw do
#   mount Analytics::Engine => Rails.configuration.analytics[:route_scope]
# end

Analytics::Engine.routes.draw do
  scope module: Analytics.route_scope do
    resources :page_views, only: [:create], defaults: { format: :json }
  end
end
