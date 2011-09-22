class CreateRespuesta < ActiveRecord::Migration
  def change
    create_table :respuesta do |t|
      t.references :encuestado
      t.references :pregunta
      t.references :opcion
      t.timestamps
    end
  end
end
