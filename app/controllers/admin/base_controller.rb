module Admin
  class BaseController < ApplicationController
    include Domain::Admin::BaseConcern

    layout 'admin'
  end
end
