class AddLoginToEncuesta < ActiveRecord::Migration
  def change
    add_column :encuesta, :login, :boolean
  end
end
