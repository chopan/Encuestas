class CreateEncuestados < ActiveRecord::Migration
  def change
    create_table :encuestados do |t|
      t.string :sesion
      t.timestamps
    end
  end
end
