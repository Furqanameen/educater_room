module Users
  class SessionsController < Devise::SessionsController
    layout 'org_public'

    # before_action :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    # def create
    #   super
    # end

    # DELETE /resource/sign_out
    # def destroy
    #   super
    # end

    def after_sign_in_path_for(resource)
      if resource.admin?
        admin_dashboard_index_path
      elsif resource.org_owner?
        organisation_dashboard_index_path
      elsif resource.instructor?
        instructor_dashboard_index_path
      elsif resource.student?
        student_dashboard_index_path
      else
        root_path
      end
    end
  end
end
