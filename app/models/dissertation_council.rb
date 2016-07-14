class DissertationCouncil < ActiveRecord::Base
  has_many :council_specialities_dissertation_councils, dependent: :destroy
  has_many :specialities, through: :council_specialities_dissertation_councils, source: :council_speciality

  has_many :posts,  as: :context, dependent: :destroy
  has_many :people, through: :posts

  has_many :clerks, as: :context, dependent: :destroy, class_name: 'Permission'

  validates :number, presence: true, uniqueness: true

  normalize_attribute :number, with: :squish

  scope :ordered, -> { order :number }

  extend FriendlyId

  friendly_id :number

end

# == Schema Information
#
# Table name: dissertation_councils
#
#  id         :integer          not null, primary key
#  number     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#
# Indexes
#
#  index_dissertation_councils_on_slug  (slug) UNIQUE
#
