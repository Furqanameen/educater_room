module Users
  class RegistrationsController < Devise::RegistrationsController
    layout 'org_public'

    before_action :configure_sign_up_params, only: [:create]

    # GET /resource/sign_up
    # def new
    #   super
    # end

    # POST /resource
    def create
      super
      resource.student!
    end

    # GET /resource/edit
    # def edit
    #   super
    # end

    # PUT /resource
    # def update
    # end

    # DELETE /resource
    # def destroy
    #   super
    # end

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
    end

    def after_sign_up_path_for(_resource)
      student_dashboard_index_path
    end
  end
end
