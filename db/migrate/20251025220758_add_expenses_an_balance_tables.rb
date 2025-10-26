class AddExpensesAnBalanceTables < ActiveRecord::Migration[8.0]
  def up
    create_table :expenses do |t|
      t.bigint  :payer_id, null: false
      t.bigint  :group_id, null: false
      t.integer :category, null: false
      t.decimal :paid_value, null: false, precision: 10, scale: 2
      t.date    :date, null: false
      t.text    :description

      t.timestamps
    end

    add_foreign_key :expenses, :users, column: :payer_id
    add_foreign_key :expenses, :groups

    create_table :group_balances do |t|
      t.bigint  :group_id, null: false
      t.bigint  :user_id, null: false
      t.integer :month, null: false
      t.integer :year, null: false
      t.decimal :total_paid_value, null: false, default: 0.0, precision: 10, scale: 2
      t.decimal :balance, null: false, default: 0.0, precision: 10, scale: 2
      t.integer :lock_version

      t.timestamps
    end

    add_index       :group_balances, [ :group_id, :user_id, :month, :year ], unique: true
    add_foreign_key :group_balances, :groups
    add_foreign_key :group_balances, :users
  end

  def down
    remove_foreign_key :expenses, :users, column: :payer_id
    remove_foreign_key :expenses, :groups

    drop_table :expenses

    remove_foreign_key :group_balances, :users
    remove_foreign_key :group_balances, :groups

    drop_table :group_balances
  end
end
