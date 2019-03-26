class ApplicationController < ActionController::API
  skip_before_action :verify_authenticity_token

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
      errors: [
        {
          status: '400',
          title: 'Bad Request',
          detail: resource.errors,
          code: '100'
        }
      ]
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

end
