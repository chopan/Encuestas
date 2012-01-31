class PreguntaTipo < ActiveRecord::Base
  validates :nombre,:presence=>true
  has_many :preguntas

end
