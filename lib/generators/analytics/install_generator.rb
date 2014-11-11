module Analytics
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../../templates', __FILE__)

      desc 'Create a analytics initializer'

      def copy_initializer
        template 'analytics.rb', 'config/initializers/analytics.rb'
      end

      def copy_migration
        migration_template 'page_view_migration.rb', 'db/migrate/add_analytics_page_view_table.rb'
      end

      def add_routes
        route "mount Analytics::Engine => '/analytics', as: 'analytics'"
      end

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime('%Y%m%d%H%M%S').to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end
    end
  end
end
