require 'net/ldap'

class Ldap

  LDAP_SERVER_IP = 'buzon.uach.mx'
  #LDAP_USERNAME = 'ldap_username'
  #LDAP_PASSWORD = 'ldap_password'

  def self.valid?(username, password)
    init "uid=#{username},ou=People,o=uach.mx,o=uach.mx", password
    @ldap.bind
  end

  protected

  def self.init(username, password)
    @ldap = Net::LDAP.new
    @ldap.host = LDAP_SERVER_IP
    @ldap.auth username, password
  end
end