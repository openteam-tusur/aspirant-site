json.id council.id
json.number council.number
json.clerks do
  json.array! council.clerks.map(&:user), partial: 'manage/angular/users', as: :user
end
json.people do
  json.array! council.people.sort_by{ |person| person.row_order_for(council) || 0 },
              partial: 'manage/angular/person',
              as: :person,
              locals: { context: council }
end
json.specialities do
  json.array! council.specialities.sort_by{ |speciality| speciality.row_order_for(council) || 0 },
              partial: 'manage/angular/council_speciality',
              as: :speciality
end
