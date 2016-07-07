class Permission < ActiveRecord::Base
  include AuthClient::Permission

  acts_as_auth_client_permission roles: [:admin, :clerk]

  attr_accessor :name

  validates_uniqueness_of :role, :scope => :user_id,
    :message => 'У пользователя не может быть несколько одинаковых ролей'

  def self.localized_available_roles
    available_roles.map do |role|
      {
        localized: I18n.t(%Q(permissions.#{role})),
        value: role,
        need_context: role == 'clerk' ? true : false
      }
    end
  end

  def self.available_contexts
    DissertationCouncil.ordered
  end
end

# == Schema Information
#
# Table name: permissions
#
#  id           :integer          not null, primary key
#  user_id      :string
#  context_id   :integer
#  context_type :string
#  role         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
