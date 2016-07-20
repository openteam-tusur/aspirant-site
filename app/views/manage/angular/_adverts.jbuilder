json.array! adverts do |advert|
  json.id advert.id
  json.title advert.title
  json.applicant advert.applicant,
                 partial: 'manage/angular/person',
                 as: :person
  json.publication_date I18n.l(advert.publication_date, format: :long)
end
