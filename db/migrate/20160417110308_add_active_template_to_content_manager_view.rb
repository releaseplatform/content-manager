class AddActiveTemplateToContentManagerView < ActiveRecord::Migration
  def change
    add_column :content_manager_views, :active_template, :string
  end
end
