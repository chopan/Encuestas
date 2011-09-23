class Session < ActiveRecord::Base
  attr_reader :session_id
  attr_accessor :data
end
