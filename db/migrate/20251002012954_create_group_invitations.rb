class CreateGroupInvitations < ActiveRecord::Migration[8.0]
  def up
    create_table :group_invitations do |t|
      t.string :email_address, null: false
      t.integer :status, null: false, default: 0
      t.bigint :group_id, null: false
      t.bigint :inviter_id, null: false

      t.timestamps
    end

    add_index :group_invitations, :email_address
    add_index :group_invitations, :group_id
    add_index :group_invitations, :inviter_id
    add_index :group_invitations, [ :email_address, :group_id ], unique: true
    add_foreign_key :group_invitations, :groups
    add_foreign_key :group_invitations, :users, column: :inviter_id
    add_foreign_key :group_invitations, :users, column: :email_address, primary_key: :email_address
  end

  def down
    remove_index :group_invitations, column: :email_address
    remove_index :group_invitations, column: :group_id
    remove_index :group_invitations, column: :inviter_id
    remove_index :group_invitations, column: [ :email_address, :group_id ]
    remove_foreign_key :group_invitations, :groups
    remove_foreign_key :group_invitations, :users, column: :inviter_id
    remove_foreign_key :group_invitations, :users, column: :email_address

    drop_table :group_invitations
  end
end
