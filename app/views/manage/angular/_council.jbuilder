json.id council.id
json.number council.number
json.clerks do 
  json.array! council.clerks.map(&:user), partial: 'manage/angular/users', as: :user
end
