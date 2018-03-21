Amber::Server.configure do |app|
  pipeline :api do
    plug Amber::Pipe::PoweredByAmber.new
    plug Amber::Pipe::Error.new
    plug Amber::Pipe::Logger.new
    plug JsonHandler.new
  end

  routes :api do
    resources "/users", UserController, except: [:new, :create, :edit]
  end
end
