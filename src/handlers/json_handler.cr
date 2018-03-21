class JsonHandler
  include HTTP::Handler

  def call(context)
    context.response.headers["Content-Type"] = "application/json"
    call_next(context)
  end
end
