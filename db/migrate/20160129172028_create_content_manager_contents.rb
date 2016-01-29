class CreateContentManagerContents < ActiveRecord::Migration
  def change
    create_table :content_manager_contents do |t|
      t.integer :version
      t.text :data
      t.references :view, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
