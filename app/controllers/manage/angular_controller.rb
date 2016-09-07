class Manage::AngularController < Manage::ApplicationController
  load_and_authorize_resource class: :angular

  def get_locale_hash
    @locale = I18n.backend.send(:translations)[I18n.locale]
  end

  def get_science_degrees_and_titles
    file = File.open(%Q(#{Rails.root.join}/config/science_degrees_and_titles.yml))
    degrees_and_titles = YAML.load file

    @degrees_and_titles = {}
    degrees_and_titles.each do |key,value|
      temp_array = value.map do |abbr_with_value|
        abbr, value = abbr_with_value
        {
          abbr: abbr,
          value: value.mb_chars.capitalize
        }
      end
      @degrees_and_titles[key] = temp_array
    end
  end

  def get_enumerize_values
    values = params[:class_name].constantize.send(params[:enumerize_value]).options
    @values = values.map do |localized, enumerized|
      {
        localized: localized,
        enumerized: enumerized
      }
    end
  end

  def get_current_user_info
  end
end
