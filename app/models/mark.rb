class Mark < ActiveRecord::Base
  belongs_to :order_line
  validates_presence_of :name
end
