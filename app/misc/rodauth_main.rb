require "sequel/core"

class RodauthMain < Rodauth::Rails::Auth
  configure do
    enable :create_account, :verify_account_grace_period, :login, :logout,
      :change_password, :email_auth, :webauthn_login

    db Sequel.sqlite(extensions: :activerecord_connection, keep_reference: false)
    rails_controller { RodauthController }
    account_status_column :status
    account_password_hash_column :password_hash

    create_account_set_password? false
    verify_account_set_password? false
    webauthn_login_user_verification_additional_factor? true
  end
end
