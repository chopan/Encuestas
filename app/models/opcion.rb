class Opcion < ActiveRecord::Base
  belongs_to :pregunta
  belongs_to :opcion_tipo
end
