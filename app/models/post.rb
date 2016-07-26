class Post < ActiveRecord::Base
  include RankedModel

  ranks :row_order, with_same: [:context_id, :context_type]
  after_destroy :destroy_associated_files
  before_create :create_snapshot

  belongs_to :context, polymorphic: true
  belongs_to :person

  belongs_to :speciality, class_name: 'CouncilSpeciality', foreign_key: 'council_speciality_id'

  serialize :snapshot, Hash

  [:applicant, :mentor, :opponent, :reviewer].each do |scope_name|
    scope scope_name , -> { where(person_type: scope_name) }
  end

  def destroy_associated_files
    available_files_array = %w(opponent reviewer)
    if context.is_a?(Advert) && available_files_array.include?(person_type)
      person.send(%Q(#{person_type}_files), context).compact.map(&:destroy)
    end
  end

  def create_snapshot
    self.snapshot = person.attributes
  end
end

# == Schema Information
#
# Table name: posts
#
#  id                    :integer          not null, primary key
#  context_id            :integer
#  context_type          :string
#  person_id             :integer
#  title                 :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  row_order             :integer
#  person_type           :string
#  snapshot              :text
#  council_speciality_id :integer
#
# Indexes
#
#  index_posts_on_council_speciality_id  (council_speciality_id)
#
# Foreign Keys
#
#  fk_rails_7ce37916aa  (council_speciality_id => council_specialities.id)
#
