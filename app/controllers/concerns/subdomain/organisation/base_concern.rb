module Subdomain::Organisation::BaseConcern
  extend ActiveSupport::Concern

  # Includes all necessary concerns and it is required in organisation base controller.

  include Subdomain::SubdomainConcern
  include Subdomain::Organisation::ValidateConcern
end
