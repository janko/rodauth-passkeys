class CreateRodauthEmailAuthWebauthn < ActiveRecord::Migration[7.2]
  def change
    # Used by the email auth feature
    create_table :account_email_auth_keys, id: false do |t|
      t.integer :id, primary_key: true
      t.foreign_key :accounts, column: :id
      t.string :key, null: false
      t.datetime :deadline, null: false
      t.datetime :email_last_sent, null: false, default: -> { "CURRENT_TIMESTAMP" }
    end

    # Used by the webauthn feature
    create_table :account_webauthn_user_ids, id: false do |t|
      t.integer :id, primary_key: true
      t.foreign_key :accounts, column: :id
      t.string :webauthn_id, null: false
    end
    create_table :account_webauthn_keys, primary_key: [:account_id, :webauthn_id] do |t|
      t.references :account, foreign_key: true
      t.string :webauthn_id
      t.string :public_key, null: false
      t.integer :sign_count, null: false
      t.datetime :last_use, null: false, default: -> { "CURRENT_TIMESTAMP" }
    end
  end
end
