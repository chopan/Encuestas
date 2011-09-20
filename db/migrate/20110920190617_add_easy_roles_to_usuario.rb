class AddEasyRolesToUsuario < ActiveRecord::Migration
  def self.up
    
    add_column :usuarios, :roles, :string, :default => "--- []"
  end

  def self.down
    remove_column :usuario, :roles
  end
end
