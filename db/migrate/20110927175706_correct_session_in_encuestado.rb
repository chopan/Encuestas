class CorrectSessionInEncuestado < ActiveRecord::Migration
  def up
    remove_column :encuestados, :sesion
    add_column    :encuestados, :session_id, :string
  end

  def down
    remove_column :encuestados, :session_id
    add_column    :encuestados, :sesion, :string
  end
end
