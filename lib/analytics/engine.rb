require 'analytics/analytics_configuration'

module Analytics
  class Engine < Rails::Engine
    config.analytics = AnalyticsConfiguration.new(
      route_scope: 'analytics',
      user_class: 'User'
    )

    initializer 'analytics.configure_rails_initialization' do |app|
      ActiveSupport::Notifications.subscribe 'process_action.action_controller' do
        |_, start, finish, _, payload|

        duration = (finish - start) * 1000
        payload[:duration] = duration
        next if payload[:controller] == 'Analytics::EventsController'
        Analytics::PageView.create_from_payload(payload)
      end
    end
  end
end
