class AddShrewPageViewTable < ActiveRecord::Migration
  def change
    create_table :shrew_page_views do |t|
      t.integer         :user_id
      t.string          :controller
      t.string          :action
      t.string          :path
      t.integer         :status
      t.integer         :start_time
      t.integer         :duration
      t.float           :view_runtime
      t.float           :db_runtime
      t.integer         :sent_time, limit: 8
      t.integer         :js_return_time, limit: 8
      t.column          :js_tracking_id, 'char(16)'
    end

    add_index :shrew_page_views, :user_id
    add_index :shrew_page_views, :js_tracking_id
  end
end