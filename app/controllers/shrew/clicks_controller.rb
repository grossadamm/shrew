module Shrew
  class ClicksController < ApplicationController
    def create
      empty_response && return unless validate_params

      click = Shrew::Click.new(params)
      empty_response && return unless page_view

      page_view.js_return_time = params[:jRT]
      page_view.save

      empty_response
    end

    private

    def empty_response
      render json: []
    end

    def validate_params
      params[:jTI].present? &&
        params[:url].present? &&
        params[:x].present? &&
        params[:y].present? &&
        params[:height].present? &&
        params[:width].present? &&
    end
  end
end
