# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_wilkinsbrains_session',
  :secret      => '73a127f8c45914068719a619beda3d7c5a6d187b47f18916f4b665f79d6417c226abda33e1be039a66d2b88bfa00cea15733b1d0786ec15fa9d92ad2ed9d79de'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
