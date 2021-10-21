class CreateSpaces < ActiveRecord::Migration[6.1]
  def change
    create_table :spaces do |t|
      t.string :name
      t.integer :price
      t.string :description
    end
  end
end
