ActiveSupport::Notifications.subscribe 'process_action.action_controller' do
  |_, start, finish, _, payload|

  duration = (finish - start) * 1000
  payload[:duration] = duration
  next if payload[:controller] == 'Analytics::EventsController'
  Analytics::PageView.create(payload)
end
