class CreateEncuesta < ActiveRecord::Migration
  def change
    create_table :encuesta do |t|
      t.references :creador
      t.string :nombre
      t.text :descripcion
      t.text :presentacion
      t.datetime :fecha_creacion
      t.datetime :fecha_inicio
      t.datetime :fecha_fin
      t.boolean :activa
      t.boolean :autenticada
      t.integer :campos_numerados

      t.timestamps
    end
    add_index :encuesta, :creador_id
  end
end
