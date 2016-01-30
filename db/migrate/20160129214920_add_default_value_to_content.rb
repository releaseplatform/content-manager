class AddDefaultValueToContent < ActiveRecord::Migration
  def change
    change_column :content_manager_contents, :data, :text, default: "{}"
  end
end
