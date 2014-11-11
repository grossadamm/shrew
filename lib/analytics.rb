require 'analytics/engine'
require 'analytics/tracks_page_views'

module Analytics
  def self.setup
    yield self
  end

  mattr_accessor :route_scope
  @@route_scope = 'analytics'

  mattr_accessor :user_class
  @@user_class = 'User'
end
