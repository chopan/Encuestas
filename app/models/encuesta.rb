class Encuesta < ActiveRecord::Base

  validates :nombre, :presence=>true
  
  belongs_to :creador, :class_name => "Usuario"
  has_many :temas
  has_many :preguntas, :dependent => :destroy

  accepts_nested_attributes_for :preguntas, :reject_if => lambda { |a| a[:texto].blank? }, :allow_destroy => true

  def obtener_concurrencia
    unless self.concurrencia.nil?
      concurrencia = self.concurrencia + 1
    else
      concurrencia = 1
    end
    return concurrencia
  end

end


