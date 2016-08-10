class ApplicationController < CommonController

  protect_from_forgery :with => :exception

  include Cmsable

  private

  def remote_url
    request_path, parts_params = request.fullpath.split('?')


    request_path = '/ru/ob-yavleniya-o-zaschitah-dissertatsiy' if request_path.match(/\A\/ru\/ob-yavleniya-o-zaschitah-dissertatsiy.*/)

    ["#{cms_address}#{request_path.gsub('//', '/').split('/').compact.join('/')}.json", parts_params].compact.join('?')
  end
end
