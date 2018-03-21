Amber::Server.configure do |app|
  pipeline :api do
    plug Amber::Pipe::PoweredByAmber.new
    plug Amber::Pipe::Error.new
    plug Amber::Pipe::Logger.new
  end

  routes :api do
  end
end
