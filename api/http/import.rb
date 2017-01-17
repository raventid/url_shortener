require_relative 'container'

Import = Application.injector

Application.finalize(:hiredis) do |container|
  start do
    require 'em-hiredis'
    container.register('hiredis', Hiredis.connect(ENV['DB_URL']))
    
    # This time, register our objects without passing any dependencies
    container.register "validate", -> { Validate.new }

    container.register "encode_or_save", -> { EncodeOrSave.new }
    container.register "create", -> { Create.new }

    container.register "decode_or_load", -> { DecodeOrLoad.new }
    container.register "redirect", -> { Redirect.new }

    container.register "storage", -> { Storage.new }
    container.register "adapter", -> { Hiredis.new }
    container.register "algorithm", -> { RandomString.new }
  end

  stop do
    hiredis.disconnect
  end
end
