class CreateFooters < ActiveRecord::Migration
  def change
    create_table :footers do |t|
      t.integer :encuesta_id
      t.string :texto

      t.timestamps
    end
  end
end
