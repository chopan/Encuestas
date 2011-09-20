class CreateTemas < ActiveRecord::Migration
  def change
    create_table :temas do |t|
      t.references :encuesta
      t.integer :orden
      t.string :tema,             :limit => 400

      t.timestamps
    end
    add_index :temas, :encuesta_id
  end
end
