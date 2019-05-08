class RemoveDescriptionFromNews < ActiveRecord::Migration
  def change
    remove_column :news, :description
    remove_column :news, :link
  end
end
