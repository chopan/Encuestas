class Tema < ActiveRecord::Base
  validates :orden , :presence=>true
  validates :tema, :presence=>true

  belongs_to :encuesta
end
