class ImageGeneratorController < ApplicationController

  def show
    Base64.urlsafe_decode64(params[:image])
    respond_to do |format|
      format.png do
          html = render_to_string(:template => "image_generator/invite_maker/classic.png.erb")
          kit = IMGKit.new(html, :quality => 50)
          send_data(kit.to_png, :type => "image/png", :disposition => 'inline')
      end
    end
  end
end




# @name = params["name"]
#
# respond_to do |format|
#   format.pdf do
#     render pdf: "file_name",
#     template: 'image/show.pdf.erb'
#   end
#
#   format.png do
#     html = render_to_string(:template => "image/show.png.erb")
#
#     kit = IMGKit.new(html, :quality => 50)
#
#     send_data(kit.to_png, :type => "image/png", :disposition => 'inline')
#   end
# end
