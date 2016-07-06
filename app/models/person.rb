class Person < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :councils, through: :posts, source: :context, source_type: 'DissertationCouncil'

  belongs_to :speciality
end

# == Schema Information
#
# Table name: people
#
#  id                    :integer          not null, primary key
#  name                  :string
#  surname               :string
#  patronymic            :string
#  science_degree        :string
#  science_title         :string
#  council_speciality_id :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
