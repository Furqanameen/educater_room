module Subdomain::Instructor::ValidateConcern
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
    before_action :validate_instructor

    def validate_instructor
      return redirect_to root_path, alert: 'You are not authorized to access this page' unless current_user.instructor?
    end
  end
end
