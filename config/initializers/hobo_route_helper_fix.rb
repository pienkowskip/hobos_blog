HoboRouteHelper.module_eval do
  protected

  def base_url
    if subsite && respond_to?(:"#{subsite}_root_path")
      public_send(:"#{subsite}_root_path")
    else
      root_path
    end
  end
end