class Pregunta < ActiveRecord::Base
  belongs_to :encuesta
  belongs_to :pregunta_tipo
  belongs_to :tema
end
