require 'thread'
class Encuesta < ActiveRecord::Base

  validates :nombre, :presence=>true
  
  belongs_to :creador, :class_name => "Usuario"
  has_many :temas
  has_many :preguntas, :dependent => :destroy
  has_one :encabezado
  has_one :footer

  accepts_nested_attributes_for :preguntas,  :allow_destroy => true
  accepts_nested_attributes_for :encabezado, :reject_if => lambda { |a| a[:texto].blank? },  :allow_destroy => true
  accepts_nested_attributes_for :footer, :reject_if => lambda { |a| a[:texto].blank? },  :allow_destroy => true
  
  def obtener_concurrencia
    mutex = Mutex.new
   
      mutex.synchronize do
        unless self.concurrencia.nil?
              concurrencia = self.concurrencia + 1
        else
          concurrencia = 1
        end
        return concurrencia
      end
    end
  

end


