require 'rails_helper'
require "base64"


RSpec.describe ImageGeneratorController, type: :controller do
  let(:image) {"\{\"name\" : \"Stephen\", \"movie\" : \"hi\", \"img\" : \"something.png\", \"view\": \"/invite_maker/something.png\"\}"}

  it "tried to decrypts base 64 parameters for the image" do
    encrypted_image = Base64.urlsafe_encode64(image)
    expect(Base64).to receive(:urlsafe_decode64).with(encrypted_image)
    get :show, image: encrypted_image, format: "png"
  end

end
