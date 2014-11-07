Rails.application.routes.draw do
  scope Rails.configuration.analytics.route_scope || 'analytics' do
    post 'pv' => 'analytics/page_views#create'
  end
end
