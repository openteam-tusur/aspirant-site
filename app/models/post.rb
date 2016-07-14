class Post < ActiveRecord::Base
  include RankedModel


  ranks :row_order, with_same: [:context_id, :context_type]

  belongs_to :context, polymorphic: true
  belongs_to :person


end

# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  context_id   :integer
#  context_type :string
#  person_id    :integer
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  row_order    :integer
#
