class Encuesta < ActiveRecord::Base
  belongs_to :creador, :class_name => "Usuario"
  has_many :temas

  has_many :preguntas, :dependent => :destroy

  accepts_nested_attributes_for :preguntas, :reject_if => lambda { |a| a[:texto].blank? }, :allow_destroy => true
end


