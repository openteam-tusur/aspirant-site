class Permission < ActiveRecord::Base
  include AuthClient::Permission

  acts_as_auth_client_permission roles: [:admin]

  attr_accessor :name

  validates_uniqueness_of :role, :scope => :user_id,
    :message => 'У пользователя не может быть несколько одинаковых ролей'
end
