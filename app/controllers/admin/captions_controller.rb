class Admin::CaptionsController < Admin::AdminSiteController

  hobo_model_controller

  auto_actions :all, except: :new

end
