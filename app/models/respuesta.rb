class Respuesta < ActiveRecord::Base
  belongs_to :encuestado
  has_many :opciones
  belongs_to :pregunta

end
