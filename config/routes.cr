Amber::Server.configure do |app|
  pipeline :api do
    plug JsonHandler.new
    plug Amber::Pipe::PoweredByAmber.new
    plug Amber::Pipe::Error.new
    plug Amber::Pipe::Logger.new
    plug Amber::Pipe::CORS.new(methods: %w(GET POST PUT PATCH DELETE), headers: %w(Accept Content-Type Authorization))
  end

  routes :api do
    resources "/users", UserController, except: [:new, :create, :edit]
    resources "/artists", ArtistController, except: [:new, :edit]
    resources "/artists/:id/products", ProductController, only: [:index, :create]
    resources "/products", ProductController, only: [:show, :update, :destroy]
    resources "/sales", SaleController, only: [:index, :show, :destroy]
    put "/products/:id/stock", ProductController, :stock
    put "/products/:id/replenish", ProductController, :replenish
    post "/products/:id/sell", SaleController, :create
  end
end
