class Manage::AngularController < Manage::ApplicationController
  def get_permissions
    @permissions = Permission.all
  end

  def get_locale_hash
    @locale = I18n.backend.send(:translations)[I18n.locale]
  end
end
