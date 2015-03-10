module Shrew
  class PageView < ActiveRecord::Base
    self.table_name = 'shrew_page_views'
    belongs_to :user, class_name: Shrew.user_class

    def self.create_from_payload(payload)
      attributes = payload.slice(:user_id, :controller, :status, :view_runtime,
                                 :db_runtime, :sent_time, :js_return_time,
                                 :js_tracking_id, :action, :path, :start_time,
                                 :duration, :format)
                          .merge(sent_time: milliseconds_since_epoch)
      begin
        create(attributes)
      rescue Exception
        logger.error 'Shrew could not log the page view, please verify the database is ready'
      end
    end

    private
    def self.milliseconds_since_epoch
      (Time.now.to_f * 1000).to_i
    end
  end
end
