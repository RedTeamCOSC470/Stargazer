# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_stargazer_session',
  :secret      => 'f429266799ff2b0c6c6f2f5b92dd6cedd41244bdb40eb44ebc4f7534439ea7f8d49452e66424c00bb228596ed902e58ce178bcfc7eddfd69c8e082a9b591abf2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
