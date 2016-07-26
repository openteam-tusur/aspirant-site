json.id advert.id
json.title advert.title
json.place advert.place
json.science_degree advert.science_degree
json.placement_date advert.placement_date
json.publication_date advert.publication_date
json.organization_name advert.organization_name
json.aasm_state advert.aasm_state

json.council_speciality advert.council_speciality,
                partial: 'manage/angular/council_speciality',
                as: :speciality

json.applicant Person.imitate(advert.applicant_post),
                partial: 'manage/angular/person',
                as: :person

json.mentor Person.imitate(advert.mentor_post),
                partial: 'manage/angular/person',
                as: :person

if advert.dissertation_council
  json.dissertation_council advert.dissertation_council,
                  partial: 'manage/angular/council',
                  as: :council
end

json.organization_review advert.organization_review, partial: 'manage/angular/file_copy', as: :file
json.organization_publication advert.organization_publication, partial: 'manage/angular/file_copy', as: :file
json.synopsis advert.synopsis, partial: 'manage/angular/file_copy', as: :file
json.protocol advert.protocol, partial: 'manage/angular/file_copy', as: :file
json.council_conclusion advert.council_conclusion, partial: 'manage/angular/file_copy', as: :file
json.dissertation advert.dissertation, partial: 'manage/angular/file_copy', as: :file

json.conclusion do
  json.array! advert.conclusion, partial: 'manage/angular/file_copy', as: :file
end

json.review do
  json.array! advert.review, partial: 'manage/angular/file_copy', as: :file
end

json.opponents do
  json.array! advert.opponents_post.map{ |post| Person.imitate(post) }, partial: 'manage/angular/person',
                                as: :person,
                                locals: { context: advert }
end

json.reviewers do
  json.array! advert.reviewers_post.map{ |post| Person.imitate(post) }, partial: 'manage/angular/person',
                                as: :person,
                                locals: { context: advert }
end
