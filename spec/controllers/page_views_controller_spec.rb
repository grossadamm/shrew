require 'rails_helper'

RSpec.describe Shrew::PageViewsController, type: :controller do
  routes { Shrew::Engine.routes }

  required_params = { jTI: '1', jRT: '100' }

  context 'when missing parameter' do
    required_params.each do |required_param|
      it "#{required_param} does not attempt to find a page view" do
        expect(Shrew::PageView).not_to receive(:find_by)

        post :create, required_params.slice(required_param)
      end

      it 'returns a 200 empty response anyways' do
        post :create, required_params.slice(required_param)

        expect(response.status).to eq 200
        expect(response.body).to eq '[]'
      end
    end
  end

  context 'when the javascript tracking id matches no existing page view' do
    it 'returns a 200 empty response anyways' do
      expect(Shrew::PageView).to receive(:find_by).and_return(nil)

      post :create, required_params

      expect(response.status).to eq 200
      expect(response.body).to eq '[]'
    end
  end

  context 'when successful' do
    let(:page_view) { Shrew::PageView.new }
    before(:each) do
      expect(Shrew::PageView).to receive(:find_by).and_return(page_view)
      expect(page_view).to receive(:save).and_return(true)
    end

    it 'updates the page view with the js return time' do
      post :create, required_params

      expect(page_view.js_return_time).to eq 100
    end

    it 'returns a 200 empty response' do
      post :create, required_params

      expect(response.status).to eq 200
      expect(response.body).to eq '[]'
    end
  end
end
