require "base64"
require "json"
class ImageData

  VIEW_EXTENSION = ".erb"
  DEFAULT_VIEW = "/default"

  def self.decode(data)
    new(data: JSON.parse(Base64.urlsafe_decode64(data)))
  end

  def initialize(data: data)
    @data = data.to_h
  end

  def view
    @data.fetch("view", DEFAULT_VIEW) + VIEW_EXTENSION
  end

  def locals
    locals = @data.dup
    locals.delete("view")
    locals
  end


end
