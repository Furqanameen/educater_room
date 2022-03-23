module Domain::Admin::ValidateConcern
  extend ActiveSupport::Concern

  included do
    # before_action :authenticate_user!
    # before_action :validate_admin

    def validate_admin
      return redirect_to root_path, alert: 'You are not authorized to access this page' unless current_user.admin?
    end
  end
end
