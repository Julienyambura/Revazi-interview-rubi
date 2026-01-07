# importmap-rails compatibility
Rails::Application.class_eval do
  attr_accessor :importmap unless method_defined?(:importmap) || private_method_defined?(:importmap)
  
  if method_defined?(:importmap=) || private_method_defined?(:importmap=)
    public :importmap=
  end
  if method_defined?(:importmap) || private_method_defined?(:importmap)
    public :importmap
  end
end

