class App < Sinatra::Base

  include AutoInject["storage", "create", "redirect", "validate"]

  register Sinatra::Async

  configure do
    set :threaded, false
  end

  def redis
    @redis ||= EM::Hiredis.connect
  end

  post '/' do
    content_type 'application/json'
    create.(get_url).to_json
  end

  aget '/:link' do
    redis.get(params[:link]) do |full_url|
      body "Unknown short link #{params[:link]}" unless validate.(full_url) 
      body "Got it #{full_url}" if full_url
      async_schedule { redirect to(full_url), 301 }
    end
  end

  #place some data to redis for test, remove it from here
  def place_test_data
    redis.set 'foo', 'bar'
  end

  private

  def get_url
    parsed = parse_json
    parsed["longUrl"]
  end

  def parse_json
    request.body.rewind  # in case someone already read it
    JSON.parse(request.body.read)
  end
end
