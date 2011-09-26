class Opcion < ActiveRecord::Base
  belongs_to :pregunta
  belongs_to :opcion_tipo
  has_many :respuestas, :class_name => "Respuesta", :foreign_key => "opcion_id"
end
