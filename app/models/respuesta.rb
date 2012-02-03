class Respuesta < ActiveRecord::Base
  belongs_to :encuestado
  has_many :opciones
  belongs_to :pregunta

  validates :texto, :presence => true, :if => :es_abierta?

  private
    def es_abierta?
      self.pregunta.pregunta_tipo_id == 3
    end
end
