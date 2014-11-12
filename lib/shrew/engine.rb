module Shrew
  class Engine < Rails::Engine
    initializer 'shrew.configure_rails_initialization' do |_|
      ActiveSupport::Notifications.subscribe 'process_action.action_controller' do
        |_, start, finish, _, payload|

        duration = (finish - start) * 1000
        payload[:duration] = duration
        
        payload[:start_time] = (start.to_f * 1000).to_i
        next if payload[:controller] == 'Shrew::PageViewsController' || (Shrew.exclude.present? && payload[:controller] =~ Regexp.union(Shrew.exclude))
        Shrew::PageView.create_from_payload(payload)
      end
    end
  end
end
