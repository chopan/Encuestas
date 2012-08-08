class ChangeColumnTextoOfEncabezados < ActiveRecord::Migration
  def up
    change_column :encabezados, :texto, :text
end
def down
    change_column :encabezados, :texto, :string
end

end
