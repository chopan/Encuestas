class Encuesta < ActiveRecord::Base
  belongs_to :creador, :class_name => "Usuario"
  has_many :temas
end
