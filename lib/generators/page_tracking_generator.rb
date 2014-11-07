class AnalyticsRailtie < Rails::Generators::Base
  source_root(File.expand_path(File.dirname(__FILE__)))
  def copy_initializer
    copy_file 'page_Tracking.rb', 'config/initializers/page_tracking.rb'
  end
end
