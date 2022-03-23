module Subdomain::Student::BaseConcern
  extend ActiveSupport::Concern

  # Includes all necessary concerns and it is required in student base controller.

  include Subdomain::SubdomainConcern
  include Subdomain::Student::ValidateConcern
end
