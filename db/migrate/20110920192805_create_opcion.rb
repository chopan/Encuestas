class CreateOpcion < ActiveRecord::Migration
  def change
    create_table :opciones do |t|
	t.integer :pregunta_id
	t.string :contenido
      t.timestamps
    end
  end
end
