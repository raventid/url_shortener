require 'dry/system/container'

class Application < Dry::System::Container
  configure do |config|
    config.name = :app
    config.root = Pathname('./../')
    config.auto_register = %w['lib', 'operations', 'persistence']
  end

  load_paths! 'lib', 'operations', 'persistence'
end
