class AddResultadosPublicosToEncuestas < ActiveRecord::Migration
  def change
    add_column :encuesta, :resultados_publicos, :boolean
  end
end
