class AddColumnsToUsers < ActiveRecord::Migration[8.0]
  def up
    change_table(:users) do |t|
      t.column :first_name, :string, null: false
      t.column :last_name, :string, null: false
    end
  end

  def down
    change_table(:users) do |t|
      t.remove :first_name
      t.remove :last_name
    end
  end
end
