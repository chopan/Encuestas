class PreguntaTipo < ActiveRecord::Base
  validates :nombre,:presence=>true
  validates :tipo, :presence=>true

end
