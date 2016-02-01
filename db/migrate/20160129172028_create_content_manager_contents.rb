class CreateContentManagerContents < ActiveRecord::Migration
  def change
    create_table :content_manager_contents do |t|
      t.integer :version
      t.text :data
      # sqlite to postgres migration issues:
      # http://stackoverflow.com/questions/32301686/rails-4-2-engine-reference-column-migration-fails-pgundefinedtable-error-in
      t.integer :view_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
