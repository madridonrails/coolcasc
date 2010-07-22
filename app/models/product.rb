class Product < ActiveRecord::Base

  validates_presence_of :code
  validates_presence_of :name
  validates_presence_of :retail_price
#  has_attached_file :image
  belongs_to :cover_collection
end
