class AddCheckToNews < ActiveRecord::Migration
  def change
    add_column :news, :sumcheck, :string
    add_index :news, :sumcheck, unique: true
  end
end
