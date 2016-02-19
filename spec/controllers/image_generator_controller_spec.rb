require 'rails_helper'
require "base64"


RSpec.describe ImageGeneratorController, type: :controller do
  let(:image_meta_data) {"\{\"name\" : \"Stephen\", \"movie\" : \"hi\", \"img\" : \"something.png\", \"view\": \"/invite_maker/something.png\"\}"}
  let(:encrypted_data){Base64.urlsafe_encode64(image_meta_data)}
  let(:image_data){double(:image_data, view: "image_generator/invite_maker/classic.png", locals: {"name" => "stephen"} )}

  it "extracts the data" do
    expect(ImageData).to receive(:decode).with(encrypted_data).and_return(image_data)
    get :show, image: encrypted_data, format: "png"
  end

  it "sends to default view" do
    allow(ImageData).to receive(:decode).with(encrypted_data).and_return(image_data)
    expect(response).to render_template("image_generator/invite_maker/classic.png")
  end


end
