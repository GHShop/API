require "./spec_helper"

def artist_hash
  {"introduction" => "Fake", "user_id" => "1"}
end

def artist_params
  params = [] of String
  params << "introduction=#{artist_hash["introduction"]}"
  params << "user_id=#{artist_hash["user_id"]}"
  params.join("&")
end

def create_artist
  model = Artist.new(artist_hash)
  model.save
  model
end

class ArtistControllerTest < GarnetSpec::Controller::Test
  getter handler : Amber::Pipe::Pipeline

  def initialize
    @handler = Amber::Pipe::Pipeline.new
    @handler.build :web do
      plug Amber::Pipe::Error.new
      plug Amber::Pipe::Session.new
      plug Amber::Pipe::Flash.new
    end
    @handler.prepare_pipelines
  end
end

describe ArtistControllerTest do
  subject = ArtistControllerTest.new

  it "renders artist index template" do
    Artist.clear
    response = subject.get "/artists"

    response.status_code.should eq(200)
    response.body.should contain("Artists")
  end

  it "renders artist show template" do
    Artist.clear
    model = create_artist
    location = "/artists/#{model.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Show Artist")
  end

  it "renders artist new template" do
    Artist.clear
    location = "/artists/new"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("New Artist")
  end

  it "renders artist edit template" do
    Artist.clear
    model = create_artist
    location = "/artists/#{model.id}/edit"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Edit Artist")
  end

  it "creates a artist" do
    Artist.clear
    response = subject.post "/artists", body: artist_params

    response.headers["Location"].should eq "/artists"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "updates a artist" do
    Artist.clear
    model = create_artist
    response = subject.patch "/artists/#{model.id}", body: artist_params

    response.headers["Location"].should eq "/artists"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "deletes a artist" do
    Artist.clear
    model = create_artist
    response = subject.delete "/artists/#{model.id}"

    response.headers["Location"].should eq "/artists"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end
end
