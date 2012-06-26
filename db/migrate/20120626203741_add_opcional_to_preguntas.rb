class AddOpcionalToPreguntas < ActiveRecord::Migration
  def change
    add_column :pregunta, :opcional, :boolean
  end
end
