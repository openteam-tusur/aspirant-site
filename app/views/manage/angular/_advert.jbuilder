json.id advert.id
json.title advert.title
json.science_degree advert.science_degree
json.placement_date advert.placement_date
json.place advert.place
json.publication_date advert.publication_date
json.specaility advert.council_speciality,
                partial: 'manage/angular/council_speciality',
                as: :speciality
json.applicant advert.applicant,
                partial: 'manage/angular/person',
                as: :person
json.mentor advert.mentor,
                partial: 'manage/angular/person',
                as: :person
