# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_buspass.builder_session',
  :secret      => '5fca7f580cfe417a1e9f892eeb26287b4733c4d96094e7fef067e7b3b101dd427f9cc6359ec991761a97cdbb2131221468c30066a235b531c1a3fa81e0049301'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
