class OrderLine < ActiveRecord::Base

  belongs_to :order
  belongs_to :product
  belongs_to :cover_pattern
  belongs_to :mark

  has_attached_file :image,
    :styles => {
      :thumb => "40x40", 
      :large => "300 x 300"
  }

  validates_presence_of :product_id
  validates_presence_of :cover_pattern_id
  validates_presence_of :count
  validates_presence_of :mark, :if => Proc.new{|order_line| order_line.marked?}
  validates_presence_of :mark_id, :if => Proc.new{|order_line| order_line.marked?}
  validates_presence_of :mark_price, :if => Proc.new{|order_line| order_line.marked?}
  validates_numericality_of :mark_price, :greater_than => 0, :if => Proc.new{|order_line| order_line.marked? and !order_line.mark_price.blank?}
  validates_numericality_of :count, :greater_than => 0, :only_integer => true, :allow_nil => true
  validates_attachment_presence :image, :if => Proc.new{|order_line| order_line.marked?}
  validates_attachment_content_type :image,
    :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png']

  def self.destroy_pics(order, order_lines)
    OrderLine.find(order_lines, :conditions => {:order_id => order}).each(&:destroy)
  end

  def total_price
    unit_price = self.product.retail_price
    unit_price += self.mark_price if self.marked?
    unit_price * self.count
  end
end
