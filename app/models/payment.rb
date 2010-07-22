class Payment < ActiveRecord::Base
  has_many :clients
end
