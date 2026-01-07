# Patch for Ruby 2.6 compatibility with Rails 6.0
# Ensure Logger is defined before ActiveSupport tries to use it
unless defined?(Logger)
  require 'logger'
end

# Ensure Logger is available in ActiveSupport::LoggerThreadSafeLevel
module ActiveSupport
  module LoggerThreadSafeLevel
    unless const_defined?(:Logger)
      const_set(:Logger, ::Logger)
    end
  end
end





