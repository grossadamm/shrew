module Analytics
  class PageViewsController < ApplicationController
    def create
      empty_response && return unless params[:jTI].present? && params[:jRT].present?

      page_view = Analytics::PageView.find_by js_tracking_id: params[:jTI]
      empty_response && return unless page_view

      page_view.js_return_time = params[:jRT]
      page_view.save

      empty_response
    end

    private

    def empty_response
      render json: []
    end
  end
end
