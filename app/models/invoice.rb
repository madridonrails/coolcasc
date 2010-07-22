class Invoice < ActiveRecord::Base
  
  belongs_to :order

  validates_presence_of :order_id
  validates_presence_of :code
  validates_presence_of :delivery_date
  validates_presence_of :charge_date
  validates_presence_of :amount_charged
  validates_presence_of :freight
  
end
