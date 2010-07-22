class DeliveryNote < ActiveRecord::Base

  belongs_to :order

  validates_presence_of :code
  validates_presence_of :delivery_date
  validates_uniqueness_of :order_id

end
