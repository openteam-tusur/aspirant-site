json.councils do
  json.array! councils, partial: 'manage/angular/council', as: :council
end
