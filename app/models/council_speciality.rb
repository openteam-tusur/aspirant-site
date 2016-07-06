class CouncilSpeciality < ActiveRecord::Base
  has_and_belongs_to_many :councils, class_name: 'DissertationCouncil'
  has_many :persons
end

# == Schema Information
#
# Table name: council_specialities
#
#  id           :integer          not null, primary key
#  code         :string
#  title        :string
#  science_type :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
