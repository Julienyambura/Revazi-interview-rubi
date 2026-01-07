require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

# importmap-rails compatibility
Rails::Application.class_eval do
  if method_defined?(:importmap=) || private_method_defined?(:importmap=)
    public :importmap=
  end
  if method_defined?(:importmap) || private_method_defined?(:importmap)
    public :importmap
  end
end

module TryonApp
  class Application < Rails::Application
    config.load_defaults 6.0
    config.api_only = false
    config.assets.enabled = true
    
    config.before_initialize do
      Rails::Application.class_eval do
        unless method_defined?(:importmap)
          attr_accessor :importmap
        end
        public :importmap= if method_defined?(:importmap=)
        public :importmap if method_defined?(:importmap)
      end
    end
  end
end

