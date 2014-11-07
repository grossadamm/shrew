module Analytics
  class PageView < ActiveRecord::Base
    belongs_to :user, class_name: Rails.configuration.analytics.user_class || 'User'
  end
end