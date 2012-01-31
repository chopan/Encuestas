class CreatePreguntaTipos < ActiveRecord::Migration
  def change
    create_table :pregunta_tipos do |t|
      t.string :nombre,         :limit => 50
      t.string :descripcion,    :limit => 300

      t.timestamps
    end
  end
end
