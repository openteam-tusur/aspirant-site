class User

  include AuthClient::User
  include TusurHeader::MenuLinks

  acts_as_auth_client_user

  def app_name
    'tusur'
  end

end
