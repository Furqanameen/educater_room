module Subdomain::SubdomainConcern
  extend ActiveSupport::Concern

  # Contains code that is needed by whole tenant.

  included do
    before_action :set_current_organization

    attr_reader :current_organization

    def set_current_organization
      @current_organization = Organization.last
    end
  end
end
