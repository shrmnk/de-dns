class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    authed = warden.authenticate(auth_options)
    if authed.nil?
      render json: {
        status: 401,
        title: 'Unauthorized',
        errors: ['Invalid email and/or password']
      }, status: :unauthorized
    else
      self.resource = authed
      sign_in(resource_name, resource)
      render json: {
        status: 200,
        title: 'Success',
        message: 'Signed In'
      }, status: :ok
    end
  end

  private

  def respond_with(resource, _opts = {})
    render json: resource
  end

  def respond_to_on_destroy
    head :no_content
  end

end
