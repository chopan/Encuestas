class Pregunta < ActiveRecord::Base
  validates :texto, :presence=>true

  belongs_to :encuesta
  belongs_to :pregunta_tipo
  belongs_to :tema

  has_many :opciones, :dependent => :destroy
  accepts_nested_attributes_for :opciones,  :allow_destroy => true

  validates :texto, :presence => true
 validate :checar_opciones
 def checar_opciones
   if self.opciones.size == 0
     puts "si es cero"
      errors[:opciones] = "no puede ser cero"
   end
 end
 
end
