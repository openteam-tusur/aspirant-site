class Person < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :councils, through: :posts, source: :context, source_type: 'DissertationCouncil'

  has_many :people

  belongs_to :speciality, class_name: 'CouncilSpeciality', foreign_key: 'council_speciality_id'

  searchable do
    text :fullname
    integer :id
  end

  def fullname
    [surname, name, patronymic] * ' '
  end

  def post_for(context)
    posts.find_by(context_id: context.id)
  end

  def row_order_for(council)
    post_for(council).row_order
  end

  %w(opponent_review publication reviewer_review).each do |method_name|
    define_method %Q(#{method_name}_for) do |context|
      context.send(method_name).find_by(person_id: self.id)
    end
  end

  def opponent_files(context)
    [opponent_review_for(context), publication_for(context)]
  end

  def reviewer_files
    [reviewer_review]
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
#  science_degree_abbr   :string
#  science_title_abbr    :string
#  work_place            :text
#  work_post             :text
#
