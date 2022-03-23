module Instructor
  class BaseController < ApplicationController
    include Subdomain::Instructor::BaseConcern

    layout 'instructor'
  end
end
