class Advert < ActiveRecord::Base
  has_paper_trail
  belongs_to :council_speciality
  belongs_to :dissertation_council

  %w(applicant mentor).each do |association_name|
    has_one %Q(#{association_name}_post).to_sym, -> { send association_name },
             as: :context,
             dependent: :destroy,
             class_name: 'Post'
    has_one association_name.to_sym, through: %Q(#{association_name}_post).to_sym, source: :person
  end

  %w(opponents reviewers).each do |association_name|
    has_many %Q(#{association_name}_post).to_sym, -> { send association_name.singularize },
             as: :context,
             dependent: :destroy,
             class_name: 'Post'
    has_many association_name.to_sym,
             through: %Q(#{association_name}_post).to_sym,
             source: :person
  end

  %w(dissertation synopsis protocol council_conclusion
     organization_review organization_publication).each do |association_name|
    has_one association_name.to_sym, -> { send :with_kind, association_name },
            as: :context,
            dependent: :destroy,
            class_name: 'FileCopy'
  end

  %w(review conclusion opponent_review publication reviewer_review).each do |association_name|
    has_many association_name.to_sym, -> { send :with_kind, association_name },
             as: :context,
             dependent: :destroy,
             class_name: 'FileCopy'
  end

  before_create :set_current_date

  scope :publicated, -> { where(aasm_state: 'publicated') }

  include AASM

  aasm whiny_transitions: false do
    state :draft, initial: true
    state :publicated

    event :publish do
      transitions from: :draft, to: :publicated
    end

    event :unpublish do
      transitions from: :publicated, to: :draft
    end
  end

  def file_copies_data
    file_copies = {}
    %w(dissertation synopsis protocol
       council_conclusion review conclusion).each do |key|
         file_copies[key] = send(key) if send(key).present?
    end

    file_copies
  end

  def file_copy_versions
    PaperTrail::Version.where_object(context_id: id) + PaperTrail::Version.where_object_changes(context_id: id)
  end

  private

  def set_current_date
    self.publication_date = Date.today
    self.placement_date = Date.today
  end
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
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  title                   :text
#  organization_name       :string
#  aasm_state              :string
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
