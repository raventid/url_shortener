class Validate
  def call(url)
    !(url.nil? || url == '')
  end
end

