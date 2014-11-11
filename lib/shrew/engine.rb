module Shrew
  class Engine < Rails::Engine
    initializer 'shrew.configure_rails_initialization' do |_|
      ActiveSupport::Notifications.subscribe 'process_action.action_controller' do
        |_, start, finish, _, payload|

        duration = (finish - start) * 1000
        payload[:duration] = duration
        next if payload[:controller] == 'Shrew::PageViewsController'
        Shrew::PageView.create_from_payload(payload)
      end
    end
  end
end
