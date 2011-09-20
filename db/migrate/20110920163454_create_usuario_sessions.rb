class CreateUsuarioSessions < ActiveRecord::Migration
  def change
    create_table :usuario_sessions do |t|

      t.timestamps
    end
  end
end
