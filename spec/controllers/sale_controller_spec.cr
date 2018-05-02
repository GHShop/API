require "./spec_helper"

def sale_hash
  {"count" => "1", "price" => "1", "product_id" => "1", "clerk_id" => "1"}
end

def sale_params
  params = [] of String
  params << "count=#{sale_hash["count"]}"
  params << "price=#{sale_hash["price"]}"
  params << "product_id=#{sale_hash["product_id"]}"
  params << "clerk_id=#{sale_hash["clerk_id"]}"
  params.join("&")
end

def create_sale
  model = Sale.new(sale_hash)
  model.save
  model
end

class SaleControllerTest < GarnetSpec::Controller::Test
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

describe SaleControllerTest do
  subject = SaleControllerTest.new

  it "renders sale index template" do
    Sale.clear
    response = subject.get "/sales"

    response.status_code.should eq(200)
    response.body.should contain("Sales")
  end

  it "renders sale show template" do
    Sale.clear
    model = create_sale
    location = "/sales/#{model.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Show Sale")
  end

  it "renders sale new template" do
    Sale.clear
    location = "/sales/new"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("New Sale")
  end

  it "renders sale edit template" do
    Sale.clear
    model = create_sale
    location = "/sales/#{model.id}/edit"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Edit Sale")
  end

  it "creates a sale" do
    Sale.clear
    response = subject.post "/sales", body: sale_params

    response.headers["Location"].should eq "/sales"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "updates a sale" do
    Sale.clear
    model = create_sale
    response = subject.patch "/sales/#{model.id}", body: sale_params

    response.headers["Location"].should eq "/sales"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "deletes a sale" do
    Sale.clear
    model = create_sale
    response = subject.delete "/sales/#{model.id}"

    response.headers["Location"].should eq "/sales"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end
end
