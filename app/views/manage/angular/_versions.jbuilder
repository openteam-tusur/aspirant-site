json.array! versions do |version|
  json.id version.id
  json.item_type version.item_type
  json.item_id version.item_id
  json.event version.event
  json.whodunnit do
    user = User.find_by(id: version.whodunnit)
    json.fullname user.fullname
  end

  json.changes version.changeset.except(:created_at, :updated_at, :id) do |item|
    case item.first
      when 'dissertation_council_id'
        json.set! I18n.t("advert.dissertation_council"), set_council_numbers(item)
      when 'aasm_state'
        json.set! I18n.t("advert.aasm_state"), set_aasm_states(item)
      else
        json.set! I18n.t("advert.#{item.first}"), item.second
    end
  end

  json.created_at I18n.l(version.created_at, format: :long)
end
