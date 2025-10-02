class CreateMemberships < ActiveRecord::Migration[8.0]
  def up
    create_table :memberships do |t|
      t.bigint :user_id, null: false
      t.bigint :group_id, null: false
      t.integer :role, null: false, default: 0

      t.timestamps
    end

    add_index :memberships, :user_id
    add_index :memberships, :group_id
    add_index :memberships, [ :user_id, :group_id ], unique: true
    add_foreign_key :memberships, :users
    add_foreign_key :memberships, :groups
  end

  def down
    remove_index :memberships, column: :user_id
    remove_index :memberships, column: :group_id
    remove_index :memberships, column: [ :user_id, :group_id ]
    remove_foreign_key :memberships, :users
    remove_foreign_key :memberships, :groups

    drop_table :memberships
  end
end
