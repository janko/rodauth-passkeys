class CreateRodauth < ActiveRecord::Migration[7.2]
  def change
    create_table :accounts do |t|
      t.integer :status, null: false, default: 1
      t.string :email, null: false
      t.index :email, unique: true, where: "status IN (1, 2)"
      t.string :password_hash
    end

    # Used by the account verification feature
    create_table :account_verification_keys, id: false do |t|
      t.integer :id, primary_key: true
      t.foreign_key :accounts, column: :id
      t.string :key, null: false
      t.datetime :requested_at, null: false, default: -> { "CURRENT_TIMESTAMP" }
      t.datetime :email_last_sent, null: false, default: -> { "CURRENT_TIMESTAMP" }
    end
  end
end
