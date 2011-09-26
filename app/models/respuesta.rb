class Respuesta < ActiveRecord::Base
  belongs_to :encuestado
  belongs_to :opcion
  belongs_to :pregunta

end
