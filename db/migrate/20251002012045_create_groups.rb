class CreateGroups < ActiveRecord::Migration[8.0]
  def up
    create_table :groups do |t|
      t.string :name, null: false
      t.text :description, null: false

      t.timestamps
    end
  end

  def down
    drop_table :groups
  end
end
