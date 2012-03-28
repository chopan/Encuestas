class UsuarioSession < Authlogic::Session::Base
  def to_key
    [session_key]
  end

   if Encuestas::Application.config.ldap_auth
    verify_password_method :valid_ldap_credentials?
  end
  
end
