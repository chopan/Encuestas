class AddTextoToRespuestas < ActiveRecord::Migration
  def change
    add_column :respuesta, :texto, :string
  end
end
