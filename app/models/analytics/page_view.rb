module Analytics
  class PageView < ActiveRecord::Base
    self.table_name = 'analytics_page_views'
    belongs_to :user, class_name: Rails.configuration.analytics[:user_class]

    def self.create_from_payload(payload)
      valid_attributes = [
        :user_id, :controller, :status, :view_runtime,
        :db_runtime, :sent_time, :js_return_time, :js_tracking_id
      ]
      create(payload.slice(valid_attributes))
    end
  end
end
