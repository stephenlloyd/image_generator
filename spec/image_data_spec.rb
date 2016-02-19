require "image_data"
require "base64"
require "json"

describe ImageData do
  let(:data){{"name" => "Stephen", "movie" => "hi", "img" => "something.png", "view" => "/invite_maker/something.png", "quality" => "60"}}
  let(:no_name_view_data){{"movie" => "hi", "img" => "something"}}
  let(:json_data){data.to_json}
  let(:json_no_name_view_data){no_name_view_data.to_json}
  let(:no_view_encoded_data){Base64.urlsafe_encode64(json_no_name_view_data)}
  let(:encoded_data){Base64.urlsafe_encode64(json_data)}
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

  it("can extract the name from encoded data") do
    expect(subject.name).to eq "Stephen"
  end

  it "can extract a default name" do
    subject = described_class.decode(no_view_encoded_data)
    expect(subject.name).to eq no_name_view_data.hash
  end

  it("can extract the quality from encoded data") do
    expect(subject.quality).to eq 60
  end

  it "can extract a default name" do
    subject = described_class.decode(no_view_encoded_data)
    expect(subject.quality).to eq 50
  end
end
