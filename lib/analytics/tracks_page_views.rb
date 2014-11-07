module Analytics
  module TracksPageViews
    extend ActiveSupport::Concern

    def append_info_to_payload(payload)
      super
      return unless @_tracking_page_views
      payload[:user_id] = current_user.try(:id)
      payload[:js_tracking_id] = @_js_tracking_id
    end

    module ClassMethods
      def tracks_page_views
        @_tracking_page_views = true
        @_js_tracking_id = SecureRandom.uuid
      end
    end
  end
end

ActiveSupport.on_load(:action_controller) do
  include Analytics::TracksPageViews
end