# This file must be required before bundler/setup to ensure Logger is available
require 'logger'

# Ensure Logger is available to ActiveSupport
unless defined?(Logger)
  require 'logger'
end





