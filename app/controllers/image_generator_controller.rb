require 'image_data'
class ImageGeneratorController < ApplicationController

  def show
    image_data = ImageData.decode(params[:image])
    image_data.locals.each {|k,v|instance_variable_set("@#{k}", v )}

    respond_to do |format|
        format.pdf do
          render pdf: image_data.name,
          template: image_data.view
        end

      format.png do
          html = render_to_string(:template => image_data.view)
          kit = IMGKit.new(html, :quality => image_data.quality)
          send_data(kit.to_png, :type => "image/png", :disposition => 'inline')
      end
    end
  end
end
