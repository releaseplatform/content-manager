class CreateContentManagerViews < ActiveRecord::Migration
  def change
    create_table :content_manager_views do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
