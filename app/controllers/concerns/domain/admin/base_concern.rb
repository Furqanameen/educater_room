module Domain::Admin::BaseConcern
  extend ActiveSupport::Concern

  # Includes all necessary concerns and it is required in admin base controller.

  include Domain::Admin::ValidateConcern
end
