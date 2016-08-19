json.array! versions do |version|
  json.id version.id
  json.item_type version.item_type
  json.item_id version.item_id
  json.event version.event
  json.whodunnit do
    user = User.find_by(id: version.whodunnit)
    json.fullname user.fullname
  end

  json.changes version.changeset.except(:updated_at) do |item|
    if item.first == 'dissertation_council_id'
      council_numbers = []
      council_numbers << DissertationCouncil.find(item.last.first).number
      council_numbers << DissertationCouncil.find(item.last.last).number

      json.set! I18n.t("advert.dissertation_council"), council_numbers
    else
      json.set! I18n.t("advert.#{item.first}"), item.second
    end
  end

  json.created_at I18n.l(version.created_at, format: :long)
end
