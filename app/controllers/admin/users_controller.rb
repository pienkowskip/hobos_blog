class Admin::UsersController < Admin::AdminSiteController

  hobo_user_controller

  skip_before_filter :login_required, :only => [:first, :create]

  auto_actions :all, :except => [ :new, :create ]


  # Normally, users should be created via the user lifecycle, except
  #  for the initial user created via the form on the front screen on
  #  first run.  This method creates the initial user.

  def login
    if User.count == 0
      redirect_to first_admin_users_url
      return
    end
    hobo_login
  end

  def first
    redirect_to admin_root_url unless User.count == 0
  end

  def create
    redirect_to admin_root_url unless User.count == 0
    hobo_create do
      if valid?
        self.current_user = this
        flash[:notice] = t("hobo.messages.you_are_site_admin", :default=>"You are now the site administrator")
        redirect_to admin_root_url
      end
    end
  end

  def do_accept_invitation
    do_transition_action :accept_invitation do
      if this.valid?
        self.current_user = this
        flash[:notice] = t("hobo.messages.you_signed_up", :default=>"You have signed up")
      end
    end
  end
end
