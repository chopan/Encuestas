class Usuario < ActiveRecord::Base
	
  acts_as_authentic do |config|
    #Configuration Options
    config.crypto_provider = Authlogic::CryptoProviders::MD5
  end

  easy_roles :roles

  protected
    def valid_ldap_credentials?(password)
      Ldap.valid?(self.login, password)
    end

end
