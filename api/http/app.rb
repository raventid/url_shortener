class App < Sinatra::Base
  include Import["storage", "create"] 

  register Sinatra::Async

  configure do
    set :threaded, false
  end

  post '/' do
    content_type 'application/json'
    create.(get_url).to_json
  end

  aget '/:code' do
    storage.get(params[:code]) do |full_url|
      if full_url
        body "Found #{full_url}"
      else
        body "Not found #{full_url}"
      end
      async_schedule { redirect to(full_url), 301 }
    end
  end

  private

  def get_url
    parsed = parse_json
    parsed["longUrl"]
  end

  def parse_json
    request.body.rewind 
    JSON.parse(request.body.read)
  end
end
