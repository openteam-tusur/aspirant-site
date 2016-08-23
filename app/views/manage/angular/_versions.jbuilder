json.array! versions do |version|
  json.id version.id
  json.item_type version.item_type
  json.item_id version.item_id
  json.event set_event_title(version)
  json.delete_object set_deleted_object(version.object) if version.event == 'destroy'
  json.whodunnit do
    user = User.find_by(id: version.whodunnit)
    json.fullname user.fullname
  end

  json.changes version.changeset.except(:created_at, :updated_at, :id, :file_content_type,
                                        :file_file_size, :file_updated_at, :context_id,
                                        :context_type) do |item|
    case item.first
      when 'dissertation_council_id'
        json.set! I18n.t("paper_trail.dissertation_council"), set_council_numbers(item)
      when 'aasm_state'
        json.set! I18n.t("paper_trail.aasm_state.state"), set_aasm_states(item)
      when 'kind'
        json.set! I18n.t("paper_trail.kind"), set_file_kinds(item)
      when 'person_id'
        json.set! I18n.t("paper_trail.person"), set_person(item)
      else
        json.set! I18n.t("paper_trail.#{item.first}"), item.second
    end
  end

  json.created_at I18n.l(version.created_at, format: :long)
end
