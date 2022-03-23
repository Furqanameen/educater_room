module Organisation
  class BaseController < ApplicationController
    include Subdomain::Organisation::BaseConcern

    layout 'organization'
  end
end
