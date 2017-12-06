class Admin::AdminSiteController < ApplicationController

  before_filter :login_required

  hobo_controller

  def index
  end

end