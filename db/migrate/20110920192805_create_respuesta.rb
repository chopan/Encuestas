class CreateRespuesta < ActiveRecord::Migration
  def change
    create_table :respuesta do |t|
	t.integer :pregunta_id
	t.string :contenido
      t.timestamps
    end
  end
end
