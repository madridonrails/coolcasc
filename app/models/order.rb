class Order < ActiveRecord::Base
  include AASM

  before_save :disnulify_discounts

  has_many :order_lines
  has_one :delivery_note
  has_one :invoice
  belongs_to :client

  validates_presence_of :client_id
  validates_presence_of :order_date
  validates_presence_of :delivery_date
  validates_presence_of :paid_date, :if => Proc.new {|order| order.is_paid?}
  validates_presence_of :code, :unless => Proc.new {|order| order.new_record?}
  validates_presence_of :amount_paid, :if => Proc.new {|order| order.is_paid?}
  validates_uniqueness_of :code

  after_create :set_code_if_blank

  aasm_initial_state :delivery_note_pendant
  aasm_column :state
  aasm_state :delivery_note_pendant
  aasm_state :invoice_pendant
  aasm_state :completed
  aasm_state :invoice_issued
#  aasm_state :canceled

  aasm_event :created_delivery_note do
    transitions :from => :delivery_note_pendant, :to => :invoice_pendant
  end

  aasm_event :created_invoice do
    transitions :from => :invoice_pendant, :to => :completed
  end

  aasm_event :issue_invoice do
    transitions :from => :completed, :to => :invoice_issued
  end

  aasm_event :cancel_issue_invoice do
    transitions :from => :invoice_issued, :to => :completed
  end

  def set_code_if_blank
    if self.code.blank?
      self.code = self.id
      self.save
    end
  end

  def amount_before_taxes_and_discounts
    self.order_lines.inject(0) { |sum, obj | sum + (obj.count * obj.product.retail_price)} unless self.order_lines.nil?
  end

  def total_discounts
    self.sales_manager_discount + self.company_discount
  end

  def amount_after_discounts
    self.amount_before_taxes_and_discounts - (self.amount_before_taxes_and_discounts * self.total_discounts * 0.01)
  end

  def total_amount(taxes = 0)
    total = self.amount_after_discounts + taxes
    if self.freight_in_invoice? and self.invoice
      total += self.invoice.freight
    end
    return total
  end

  private

  def disnulify_discounts
   self.sales_manager_discount = 0 if self.sales_manager_discount.nil?
   self.company_discount = 0 if self.company_discount.nil?
  end

end
