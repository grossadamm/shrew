# Rails.application.routes.draw do
#   mount Analytics::Engine => Rails.configuration.analytics[:route_scope]
# end

Analytics::Engine.routes.draw do
  scope module: Rails.configuration.analytics.route_scope do
    resources :page_views, only: [:create]
  end
end