class CouncilSpeciality < ActiveRecord::Base
  extend Enumerize

  has_many :council_specialities_dissertation_councils, dependent: :destroy
  has_many :councils, through: :council_specialities_dissertation_councils, source: :dissertation_council

  has_many :people

  enumerize :science_type, in: [:technical]

  searchable do
    text    :code
    text    :title
    text    :science_type
    integer :id
  end

  def row_order_for(council)
    council_specialities_dissertation_councils.find_by(dissertation_council: council).row_order
  end
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
