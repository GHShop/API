module ErrorHelper
  STATUS_CODE = {
    bad_request: 400,
    forbidden:   403,
    not_found:   404,
  }

  def not_found!(description : String)
    error!(:not_found, description)
  end

  def bad_request!(description : String)
    error!(:bad_request, description)
  end

  def forbidden!(description : String)
    error!(:forbidden, description)
  end

  def error!(type : Symbol, description : String)
    response.status_code = STATUS_CODE[type]
    context.content = error_json(type, description)
  end

  def error_json(type : Symbol, description : String)
    JSON.build do |json|
      json.object do
        json.field "error", type.to_s
        json.field "error_description", description
      end
    end
  end
end
