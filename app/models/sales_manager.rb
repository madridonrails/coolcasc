class SalesManager < ActiveRecord::Base

  has_many :clients
#  has_one :market
#  has_one :product_family

  validates_presence_of :name
  validates_presence_of :corporate_name
  validates_presence_of :cif
  validates_presence_of :official_address

end
