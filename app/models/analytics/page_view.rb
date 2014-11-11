module Analytics
  class PageView < ActiveRecord::Base
    self.table_name = 'analytics_page_views'
    belongs_to :user, class_name: Analytics.user_class

    def self.create_from_payload(payload)
      attributes = payload.slice(:user_id, :controller, :status, :view_runtime,
                                 :db_runtime, :sent_time, :js_return_time,
                                 :js_tracking_id)
                          .merge(sent_time: milliseconds_since_epoch)
      create(attributes)
    end

    private
    def self.milliseconds_since_epoch
      (Time.now.to_f * 1000).to_i
    end
  end
end
