class CreateOpcionTipos < ActiveRecord::Migration
  def change
    create_table :opcion_tipos do |t|
      t.string :tipo
      t.string :descripcion

      t.timestamps
    end
  end
end
