class Opcion < ActiveRecord::Base
  validates :contenido ,:length => {:minimum => 2 }

  belongs_to :pregunta
  belongs_to :opcion_tipo
  has_many :respuestas, :class_name => "Respuesta", :foreign_key => "opcion_id"
end
