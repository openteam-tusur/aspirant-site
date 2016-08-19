class Manage::ApplicationController < ActionController::Base
  before_filter :set_paper_trail_whodunnit
  layout 'manage'

  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      redirect_to root_path, alert: 'Недостаточно прав для выполнения операции'
    else
      if request.headers['Angular']
        url = "#{Settings['profile.sign_in_url']}?redirect_url=#{request.headers['CurrentLocation']}"
        render json: { url: url }, status: 401
      else
        redirect_to sign_in_url, alert: 'Для доступа необходимо войти в систему'
      end
    end
  end
end
