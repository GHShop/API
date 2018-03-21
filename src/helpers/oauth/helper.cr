module OAuth::Helper
  include ErrorHelper

  @@oauth_url : String?
  @token_scopes : Array(String)?
  @token_info : TokenInfo?
  @token_string : String?

  def oauth_url
    @@oauth_url ||= Amber.settings.secrets.try(&.["oauth_url"]).not_nil!
  end

  def oauth_authenticate!(scopes : Array(String), realm = "OAuth")
    return token_missing!(realm) unless token_string
    return token_invalid!(realm) unless token_info?
    return scope_insufficient!(realm) if (token_scopes & scopes).empty?
    token_info
  end

  def token_scopes : Array(String)
    @token_scopes ||= token_info.scopes
  end

  def token_info : TokenInfo
    token_info?.not_nil!
  end

  def token_info? : TokenInfo | Nil
    @token_info ||= HTTP::Client.get(oauth_url, headers: HTTP::Headers{"Authorization" => "Bearer #{token_string}"}) do |response|
      if response.success?
        TokenInfo.from_json(response.body_io)
      else
        nil
      end
    end
  end

  def token_string : String | Nil
    @token_string ||= if (authorization = request.headers["Authorization"]?) && (token_string = authorization[/Bearer (.*)$/, 1]?)
      token_string
    else
      nil
    end
  end
end
