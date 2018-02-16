# frozen_string_literal: true

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, force: true do |t|
    ## Database authenticatable
    t.string :email,              null: true, default: ''
    t.string :encrypted_password, null: true, default: ''
    t.string :login,              null: false, default: ''

    ## Recoverable
    t.string   :reset_password_token
    t.datetime :reset_password_sent_at

    ## Rememberable
    t.datetime :remember_created_at

    ## Trackable
    t.integer  :sign_in_count, default: 0
    t.datetime :current_sign_in_at
    t.datetime :last_sign_in_at
    t.string   :current_sign_in_ip
    t.string   :last_sign_in_ip

    # LDAP attributes
    t.string :display_name, null: true, default: ''
    t.string :address,      null: true, default: ''
    t.string :admin_area,   null: true, default: ''
    t.string :department,   null: true, default: ''
    t.string :title,        null: true, default: ''
    t.string :office,       null: true, default: ''
    t.string :chat_id,      null: true, default: ''
    t.string :website,      null: true, default: ''
    t.string :affiliation,  null: true, default: ''
    t.string :telephone,    null: true, default: ''

    t.timestamps
  end
end
