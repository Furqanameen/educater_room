module Subdomain::Organisation::ValidateConcern
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
    before_action :validate_org_owner

    def validate_org_owner
      return redirect_to root_path, alert: 'You are not authorized to access this page' unless current_user.org_owner?
    end
  end
end
