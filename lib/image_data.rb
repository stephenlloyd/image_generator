require "base64"
require "json"

class ImageData

  VIEW_EXTENSION = ".erb"
  DEFAULT_VIEW = "/default"
  DEFAULT_IMAGE_QUALITY = 50

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
    @data.reject{|k,v| ["view", "name", "quality"].include?(k)}
  end

  def name
    @data.fetch("name", @data.hash)
  end

  def quality
    @data.fetch("quality", DEFAULT_IMAGE_QUALITY).to_i
  end


end
