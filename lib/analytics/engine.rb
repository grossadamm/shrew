module Analytics
  class Engine < Rails::Engine
    initializer 'analytics.configure_rails_initialization' do |_|
      ActiveSupport::Notifications.subscribe 'process_action.action_controller' do
        |_, start, finish, _, payload|

        duration = (finish - start) * 1000
        payload[:duration] = duration
        next if payload[:controller] == 'Analytics::PageViewsController'
        p "subscribed #{payload.inspect}"
        Analytics::PageView.create_from_payload(payload)
      end
    end
  end
end
