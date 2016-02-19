require "image_data"
require "base64"

describe ImageData do
  let(:data){"\{\"name\" : \"Stephen\", \"movie\" : \"hi\", \"img\" : \"something.png\", \"view\": \"/invite_maker/something.png\"\}"}
  let(:no_view_data){"\{\"name\" : \"Stephen\", \"movie\" : \"hi\", \"img\" : \"something.png\"\}"}
  let(:no_view_encoded_data){Base64.urlsafe_encode64(no_view_data)}
  let(:encoded_data){Base64.urlsafe_encode64(data)}
  let(:subject){described_class.decode(encoded_data)}

  it("can extract the view from encoded data") do
    expect(subject.view).to eq "/invite_maker/something.png.erb"
  end

  it "can extract a default view" do
    subject = described_class.decode(no_view_encoded_data)
    expect(subject.view).to eq "/default.erb"
  end

  it "can extract to local variables" do
    expect(subject.locals).to eq({"name" => "Stephen", "movie" => "hi", "img" => "something.png" })
  end
end
