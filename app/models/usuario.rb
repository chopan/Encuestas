class Usuario < ActiveRecord::Base
	
  acts_as_authentic do |config|
    #Configuration Options
    config.crypto_provider = Authlogic::CryptoProviders::MD5
  end

easy_roles :roles
end
