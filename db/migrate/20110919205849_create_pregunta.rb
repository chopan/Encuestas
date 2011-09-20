class CreatePregunta < ActiveRecord::Migration
  def change
    create_table :pregunta do |t|
      t.references  :encuesta
      t.references  :tema
      t.references  :pregunta_tipo
      t.text        :texto
      t.activa      :boolean
      t.order       :integer
      t.string      :orientacion,       :limit => 3
      t.integer     :min_opc_select
      t.integer     :max_opc_select
      t.boolean     :requerido


      t.timestamps
    end
  end
end
