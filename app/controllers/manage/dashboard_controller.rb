class Manage::DashboardController < Manage::ApplicationController
  load_and_authorize_resource class: :dashboard
  def spa
  end
end
