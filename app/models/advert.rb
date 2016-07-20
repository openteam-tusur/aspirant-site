class Advert < ActiveRecord::Base
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

  %w(dissertation synopsis protocol council_conclusion).each do |association_name|
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
