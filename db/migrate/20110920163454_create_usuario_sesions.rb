class CreateUsuarioSesions < ActiveRecord::Migration
  def change
    create_table :usuario_sesions do |t|

      t.timestamps
    end
  end
end
