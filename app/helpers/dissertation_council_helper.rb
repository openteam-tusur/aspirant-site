module DissertationCouncilHelper
  def council_person_fullname_and_posts(person)
    person_data = []
    person_data << (person.url.blank? ? person.fullname : link_to(person.fullname, person.url, html_options = { target: '_blank' }))

    if person.posts.present?
      person.posts.each do |post|
        person_data << post.title
      end
    end

    person_data.join("<br>").html_safe
  end

  def council_person_science_and_speciality(person)
    person_data = []
    person_science = []

    person_science << person.science_degree if person.science_degree.present?
    person_science << person.work_post if person.work_post.present?
    person_science.join(", ")

    person_data << person_science
    person_data.join(", ").html_safe
  end
end
