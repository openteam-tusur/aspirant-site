class DissertationCouncil < ActiveRecord::Base

  validates :number, presence: true, uniqueness: true

  normalize_attribute :number, with: :squish

  scope :ordered, -> { order :number }

end

# == Schema Information
#
# Table name: dissertation_councils
#
#  id         :integer          not null, primary key
#  number     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
