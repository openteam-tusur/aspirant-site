class User

  include AuthClient::User
  include TusurHeader::MenuLinks

  acts_as_auth_client_user

  def app_name
    'postgraduate'
  end

  Permission.available_roles.each do |role|
    define_method "#{role}?" do
      available_permissions.include? role
    end
  end

  def available_permissions
    @available_permissions ||= permissions.pluck(:role)
  end

  def has_any_permissions?
    available_permissions.any?
  end

end
