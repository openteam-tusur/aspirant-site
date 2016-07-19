json.id advert.id
json.title advert.title
json.science_degree advert.science_degree
json.placement_date advert.placement_date
json.place advert.place
json.publication_date advert.publication_date
json.council_speciality advert.council_speciality,
                partial: 'manage/angular/council_speciality',
                as: :speciality
json.applicant advert.applicant,
                partial: 'manage/angular/person',
                as: :person
json.mentor advert.mentor,
                partial: 'manage/angular/person',
                as: :person

if advert.dissertation_council
  json.dissertation_council advert.dissertation_council,
                  partial: 'manage/angular/council',
                  as: :council
end

json.dissertation advert.dissertation, partial: 'manage/angular/file_copy', as: :file
json.synopsis advert.synopsis, partial: 'manage/angular/file_copy', as: :file
json.protocol advert.protocol, partial: 'manage/angular/file_copy', as: :file
json.council_conclusion advert.council_conclusion, partial: 'manage/angular/file_copy', as: :file
json.conclusion do
  json.array! advert.conclusion, partial: 'manage/angular/file_copy', as: :file
end
json.review do
  json.array! advert.review, partial: 'manage/angular/file_copy', as: :file
end
json.opponents do
  json.array! advert.opponents, partial: 'manage/angular/person',
                                as: :person,
                                locals: { context: advert }
end
