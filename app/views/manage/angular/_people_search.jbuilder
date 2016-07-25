json.next_page result.next_page
json.previous_page result.previous_page
json.total_pages result.total_pages
json.people  do
  json.array! result, partial: 'manage/angular/person', as: :person
end
