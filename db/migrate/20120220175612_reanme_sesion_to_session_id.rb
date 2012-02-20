class ReanmeSesionToSessionId < ActiveRecord::Migration
  def change
    rename_column :encuestados, :sesion, :session_id
  end
end
