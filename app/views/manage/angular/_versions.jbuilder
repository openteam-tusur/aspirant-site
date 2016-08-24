json.array! versions do |version|
  normalizer = VersionNormalizer.new
  json.id version.id
  json.item_type version.item_type
  json.item_id version.item_id
  json.event normalizer.set_event_title(version)
  json.delete_object set_deleted_object(version.object) if version.event == 'destroy'
  json.whodunnit do
    user = User.find_by(id: version.whodunnit)
    json.fullname user.fullname
  end

  json.changes normalizer.set_version_changes(version)
  json.created_at I18n.l(version.created_at, format: :long)
end
