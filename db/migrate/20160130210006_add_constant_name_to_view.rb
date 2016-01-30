class AddConstantNameToView < ActiveRecord::Migration
  def change
    add_column :content_manager_views, :constant_name, :string, default: "", null: false
  end
end
