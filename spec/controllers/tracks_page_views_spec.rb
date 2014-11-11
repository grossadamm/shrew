require 'rails_helper'

class ApplicationController < ActionController::Base
  include Shrew::TracksPageViews
end

RSpec.describe ApplicationController do
  controller do
    def current_user
      {}
    end
    def index
      render json: 'ok'
    end
  end

  describe Shrew::TracksPageViews do
    it 'adds the js tracking id to be used in the layout' do
      get :index
      expect(assigns(:_js_tracking_id)).not_to eq nil
    end

    it 'sets that we are going to track page views to append to payload' do
      get :index
      expect(assigns(:_tracking_page_views)).to eq true
    end

    it 'creates the initial page view' do
      expect {
        get :index
      }.to change{Shrew::PageView.count}.by(1)
    end
  end
end
