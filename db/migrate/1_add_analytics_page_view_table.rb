class AddAnalyticsPageViewTable < ActiveRecord::Migration
  def change
    create_table :analytics_page_views, id: false do |t|
      t.integer         :user_id
      t.string          :controller
      t.integer         :status
      t.float           :view_runtime
      t.float           :db_runtime
      t.integer         :sent_time
      t.integer         :js_return_time
      t.binary          :js_tracking_id, limit: 16
    end

    add_index :analytics_page_views, :user_id
  end
end