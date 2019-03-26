class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    if resource.save
      render_resource(resource)
    else
      validation_error(resource)
    end
  end

end
