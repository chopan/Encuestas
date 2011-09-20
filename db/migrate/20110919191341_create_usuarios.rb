class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :login,              :limit => 100
      t.string :apellido_paterno,   :limit => 100
      t.string :apellido_materno,   :limit => 100
      t.date :fecha_alta,           :default => Date.today
      t.string :email,              :limit => 100

      t.timestamps
    end
  end
end
