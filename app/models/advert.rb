class Advert < ActiveRecord::Base
  belongs_to :council_speciality
  belongs_to :dissertation_council
  belongs_to :applicant, class_name: 'Person', foreign_key: 'applicant_id'
  belongs_to :mentor, class_name: 'Person', foreign_key: 'mentor_id'
end

# == Schema Information
#
# Table name: adverts
#
#  id                      :integer          not null, primary key
#  science_degree          :string
#  council_speciality_id   :integer
#  dissertation_council_id :integer
#  placement_date          :date
#  place                   :string
#  publication_date        :date
#  applicant_id            :integer
#  mentor_id               :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  title                   :text
#
# Indexes
#
#  index_adverts_on_council_speciality_id    (council_speciality_id)
#  index_adverts_on_dissertation_council_id  (dissertation_council_id)
#
# Foreign Keys
#
#  fk_rails_2dff29073c  (council_speciality_id => council_specialities.id)
#  fk_rails_a234ecffca  (dissertation_council_id => dissertation_councils.id)
#
