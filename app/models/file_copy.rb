class FileCopy < ActiveRecord::Base
  extend Enumerize

  belongs_to :context, polymorphic: true

  has_attached_file :file
  validates_attachment_content_type :file, content_type: /.*\Z/

  enumerize :kind, in: [:dissertation, :synopsis, :conclusion,
                        :review, :protocol, :council_conclusion],
                   scope: true
end

# == Schema Information
#
# Table name: file_copies
#
#  id                :integer          not null, primary key
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#  placement_date    :date
#  kind              :string
#  context_id        :integer
#  context_type      :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
