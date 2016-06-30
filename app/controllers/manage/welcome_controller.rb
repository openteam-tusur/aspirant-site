class Manage::WelcomeController < Manage::ApplicationController
  load_and_authorize_resource class: false

  def index
  end

end
