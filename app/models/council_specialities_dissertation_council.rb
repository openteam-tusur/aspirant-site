class CouncilSpecialitiesDissertationCouncil < ActiveRecord::Base
  include RankedModel
  ranks :row_order, with_same: :dissertation_council_id

  belongs_to :council_speciality
  belongs_to :dissertation_council
end

# == Schema Information
#
# Table name: council_specialities_dissertation_councils
#
#  id                      :integer          not null, primary key
#  dissertation_council_id :integer
#  council_speciality_id   :integer
#  row_order               :integer
#
