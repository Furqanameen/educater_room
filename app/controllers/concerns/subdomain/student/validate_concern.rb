module Subdomain::Student::ValidateConcern
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
    before_action :validate_student

    def validate_student
      return redirect_to root_path, alert: 'You are not authorized to access this page' unless current_user.student?
    end
  end
end
