json.permissions do
  json.array! @permissions, partial: 'manage/angular/permission', as: :permission
end
json.available_roles Permission.localized_available_roles
json.available_contexts do
  json.array! Permission.available_contexts, partial: 'manage/angular/context', as: :context
end
