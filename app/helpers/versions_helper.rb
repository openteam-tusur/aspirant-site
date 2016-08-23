module VersionsHelper
  def get_person(id)
    Person.find(id)
  end

  def get_label(key)
    I18n.t("paper_trail.#{key}")
  end

  def get_file_kind(kind)
    I18n.t("advert.files.#{kind}")
  end

  def set_event_title(version)
    event_title = ''
    case version.item_type
      when 'FileCopy'
        event_title += I18n.t("paper_trail.file_copy.#{version.event}")
      when 'Advert'
        event_title += I18n.t("paper_trail.advert.#{version.event}")
    end

    event_title
  end

  def set_person(item)
    person = []
    person << get_person(item.last.compact.first).fullname rescue nil
    person
  end

  def set_council_numbers(item)
    council_numbers = []
    current_number = DissertationCouncil.find(item.last.first).number rescue nil
    changed_number = DissertationCouncil.find(item.last.last).number rescue nil
    council_numbers << current_number
    council_numbers << changed_number
    council_numbers
  end

  def set_aasm_states(item)
    states = []
    states << I18n.t("paper_trail.aasm_state.#{item.last.first}") if item.last.first
    states << I18n.t("paper_trail.aasm_state.#{item.last.last}") if item.last.last
    states
  end

  def set_file_kinds(item)
    kinds = []
    item.last.compact.each do |kind|
      kinds << get_file_kind(kind)
    end
    kinds
  end

  def set_deleted_object(object)
    return unless object.present?

    deleted_object = {}
    YAML.load(object).each do |key, value|
      deleted_object[get_label(key)] = get_file_kind(value) if key == 'kind'
      deleted_object[get_label(key)] = get_person(value).fullname if key == 'person_id' && value.present?
    end

    deleted_object
  end
end
