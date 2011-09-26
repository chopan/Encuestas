class Pregunta < ActiveRecord::Base
  validates :texto, :presence=>true

  belongs_to :encuesta
  belongs_to :pregunta_tipo
  belongs_to :tema

  has_many :opciones, :dependent => :destroy
  accepts_nested_attributes_for :opciones, :reject_if => lambda { |a| a[:contenido].blank? }, :allow_destroy => true
end
