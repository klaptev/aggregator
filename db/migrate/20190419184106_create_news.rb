class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.text :description
      t.string :link
      t.text :title
      t.integer :feed_id

      t.timestamps null: false
    end
  end
end
