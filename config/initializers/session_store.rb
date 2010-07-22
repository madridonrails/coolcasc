# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_coolcasc_session',
  :secret      => '74fe9dcb9f1748dd3a8ced1831b9b19c107fa32d53570a18452135393981765bc4bdd4196b01f057b894018dde14815eb58c9106d8010164c8d1a7f38f21f9b4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
