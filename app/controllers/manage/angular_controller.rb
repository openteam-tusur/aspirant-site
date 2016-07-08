class Manage::AngularController < Manage::ApplicationController
  def get_permissions
    @permissions = Permission.all
  end

  def get_locale_hash
    @locale = I18n.backend.send(:translations)[I18n.locale]
  end

  def get_councils
    @councils = DissertationCouncil.includes(:clerks).all
  end

  def get_science_degrees_and_titles
    file = File.open(%Q(#{Rails.root.join}/config/science_degrees_and_titles.yml))
    @degrees_and_titles = YAML.load file
  end
end
