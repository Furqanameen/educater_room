module Subdomain::Instructor::BaseConcern
  extend ActiveSupport::Concern

  # Includes all necessary concerns and it is required in instructor base controller.

  include Subdomain::SubdomainConcern
  include Subdomain::Instructor::ValidateConcern
end
