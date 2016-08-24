class VersionNormalizer
  def set_version_changes(version)
    changes_object = YAML.load(version.object_changes) if version.object_changes
    result_object = {}
    if changes_object.present?
      changes_object.each do |key, value|
        result_object[get_label(key)] = set_person_fullname(value) if key == 'person_id'
        result_object[get_label(key)] = set_person_type(value)     if key == 'person_type'
        result_object[get_label(key)] = set_council_number(value)  if key == 'dissertation_council_id'
        result_object[get_label(key)] = set_council_speciality_title(value)  if key == 'council_speciality_id'
        result_object[get_label(key)] = set_file_kind(value)       if key == 'kind'
        result_object[get_label(key)] = set_state(value)       if key == 'aasm_state'
        if ['science_degree',
            'organization_name',
            'title',
            'publication_date',
            'placement_date',
            'place'].include? key
            result_object[get_label(key)] = value
        end
      end
    end

    result_object
  end

  def set_person_fullname(person_ids_array)
    person_fullnames = []
    person_ids_array.compact.each do |id|
      person_fullnames << get_person(id).fullname
    end

    person_fullnames
  end

  def set_person_type(person_types_array)
    person_types = []
    person_types_array.compact.each do |type|
      person_types << get_label(type)
    end

    person_types
  end

  def set_council_number(council_ids_array)
    council_numbers = []
    council_ids_array.compact.each do |id|
      council_numbers << get_council(id).number
    end

    council_numbers
  end

  def set_council_speciality_title(council_speciality_ids_array)
    council_speciality_titles = []
    council_speciality_ids_array.compact.each do |id|
      council_speciality_titles << get_speciality(id).title
    end

    council_speciality_titles
  end

  def set_file_kind(kinds_array)
    kinds = []
    kinds_array.compact.each do |kind|
      kinds << get_label(kind)
    end

    kinds
  end

  def set_state(states_array)
    states = []
    states_array.compact.each do |state|
      states << get_state_locale(state)
    end

    states
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

  def get_person(id)
    Person.find(id)
  end

  def get_council(id)
    DissertationCouncil.find(id)
  end

  def get_speciality(id)
    CouncilSpeciality.find(id)
  end

  def get_label(key)
    I18n.t("paper_trail.#{key}")
  end

  def get_state_locale(state)
    I18n.t("paper_trail.state.#{state}")
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
      when 'Post'
        event_title += I18n.t("paper_trail.post.#{version.event}")
    end

    event_title
  end
end
