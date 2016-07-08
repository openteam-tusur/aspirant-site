class Person < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :councils, through: :posts, source: :context, source_type: 'DissertationCouncil'

  belongs_to :speciality

  searchable do
    text :fullname
  end

  def fullname
    [surname, name, patronymic] * ' '
  end
end

# == Schema Information
#
# Table name: people
#
#  id                    :integer          not null, primary key
#  name                  :string
#  surname               :string
#  patronymic            :string
#  url                   :string
#  science_degree        :string
#  science_title         :string
#  council_speciality_id :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
