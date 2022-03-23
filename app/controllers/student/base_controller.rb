module Student
  class BaseController < ApplicationController
    include Subdomain::Student::BaseConcern

    layout 'student'
  end
end
