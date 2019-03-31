class ApplicationController < ActionController::API

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end

  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def validation_error(resource)
    render json: {
      status: 400,
      title: 'Bad Request',
      errors: resource.errors.full_messages
    }, status: :bad_request
  end

  # Use around_action :skip_bullet to skip Bullet detection
  def skip_bullet
    previous_value = Bullet.enable?
    Bullet.enable = false
    yield
  ensure
    Bullet.enable = previous_value
  end

  def fallback_index_html
    render file: 'public/index.html'
  end

end
