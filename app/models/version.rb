class Version < PaperTrail::Version
end

# == Schema Information
#
# Table name: versions
#
#  id             :integer          not null, primary key
#  item_type      :string           not null
#  item_id        :integer          not null
#  event          :string           not null
#  whodunnit      :string
#  object         :text
#  created_at     :datetime
#  object_changes :text
#
# Indexes
#
#  index_versions_on_item_type_and_item_id  (item_type,item_id)
#
