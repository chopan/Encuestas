class AddLimiteContestarToEncuestas < ActiveRecord::Migration
  def change
    add_column :encuesta, :limite_contestar, :datetime
  end
end
