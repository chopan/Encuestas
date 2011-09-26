class OpcionTipo < ActiveRecord::Base
  validates :tipo , :presence=>true

end
