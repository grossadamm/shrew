require 'shrew/engine'
require 'shrew/tracks_page_views'

module Shrew
  def self.setup
    yield self
  end

  mattr_accessor :route_scope
  @@route_scope = 'shrew'

  mattr_accessor :user_class
  @@user_class = 'User'
end
