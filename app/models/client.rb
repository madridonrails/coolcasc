class Client < ActiveRecord::Base

  belongs_to :sales_manager
  belongs_to :payment
  validates_presence_of :code
  validates_presence_of :corporate_name
  validates_presence_of :cif
  validates_presence_of :official_address

end
