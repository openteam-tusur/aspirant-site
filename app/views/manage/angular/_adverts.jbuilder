json.array! adverts do |advert|
  json.id advert.id
  json.title advert.title
  json.dissertation_council advert.dissertation_council
  json.applicant advert.applicant,
                 partial: 'manage/angular/person',
                 as: :person
  json.council_speciality advert.council_speciality
  json.placement_date I18n.l(advert.placement_date, format: :long) rescue nil
  json.publication_date I18n.l(advert.publication_date, format: :long) rescue nil
  json.aasm_state advert.aasm_state
end
