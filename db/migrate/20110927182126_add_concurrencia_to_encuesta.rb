class AddConcurrenciaToEncuesta < ActiveRecord::Migration
  def change
    add_column :encuesta, :concurrencia, :integer
  end
end
