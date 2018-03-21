class OAuth::TokenInfo
  JSON.mapping(
    user: User,
    scopes: Array(String),
    expires_in: Float64,
    client: Client,
    created_at: Time
  )

  class User
    JSON.mapping(
      id: Int64,
      email: String,
      name: String
    )
  end

  class Client
    JSON.mapping(
      id: String
    )
  end
end
