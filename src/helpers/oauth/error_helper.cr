module OAuth::ErrorHelper
  OAUTH_STATUS_CODE = {
    invalid_request:    400,
    invalid_token:      401,
    insufficient_scope: 403,
  }

  def token_missing!(realm : String)
    oauth_error!(realm, :invalid_request, t("oauth.errors.token.missing"))
    nil
  end

  def token_invalid!(realm : String)
    oauth_error!(realm, :invalid_token, t("oauth.errors.token.invalid"))
    nil
  end

  def scope_insufficient!(realm : String)
    oauth_error!(realm, :insufficient_scope, t("oauth.errors.scope.insufficient"))
    nil
  end

  def oauth_error!(realm : String, type : Symbol, description : String)
    type = :invalid_request unless OAUTH_STATUS_CODE.has_key? type
    response.status_code = OAUTH_STATUS_CODE[type]
    response.headers["WWW-Authenticate"] = oauth_error_header(realm, type, description)
    context.content = error_json(type, description)
  end

  def oauth_error_header(realm : String, type : Symbol, description : String)
    %(Bearer realm="#{realm}", error="#{type.to_s}, error_description="#{description}")
  end
end
