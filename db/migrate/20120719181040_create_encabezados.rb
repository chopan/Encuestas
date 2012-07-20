class CreateEncabezados < ActiveRecord::Migration
  def change
    create_table :encabezados do |t|
      t.integer :encuesta_id
      t.string :texto

      t.timestamps
    end
  end
end
