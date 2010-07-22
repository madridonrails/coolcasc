class InvoicesController < ApplicationController

  before_filter :find_order, :only => [:new]
  before_filter :find_invoice, :only => [:show, :print, :edit, :update]

  def find_invoice
    @invoice = Invoice.find(params[:id])
  end

  def find_order
    @order = Order.find(params[:order_id])
  end

  def show
    @order = Order.find(@invoice.order_id)
  end

  def print
    @order = Order.find(@invoice.order_id)
    @with_header = params[:with_header].blank? ? false : true
    render :layout => 'print'
  end

  def index
    @invoices = Invoice.paginate(
      :per_page => PAGINATION,
      :page => params[:page]
    )

    if @invoices.empty?
      flash[:notice] = t ('invoice.no_invoices')
    end

  end

  def edit
    @order = Order.find(@invoice.order_id)
  end

  def new
    @invoice = Invoice.find_or_initialize_by_order_id(params[:order_id])
    @invoice.code = @order.code
    @invoice.amount_charged = 0.0
  end

  def create
    @invoice = Invoice.new(params[:invoice])
    @order = Order.find(@invoice.order_id)
    if (@invoice.save)
      flash[:success] = t ('invoice.create.success')
      @order.created_invoice!
      redirect_to :action => :show, :id => @invoice.id
    else
      render :action => :new
    end
  end

  def update
    if @invoice.update_attributes(params[:invoice])
      flash[:success] = t ('invoice.update.success')
      redirect_to :action => :show, :id => @invoice.id
    else
      render :action => :edit
    end
  end

  def destroy
    if @invoice.destroy
      flash[:success] = t('invoice.destroy.success')
    else
      flash[:error] = t('invoice.destroy.error')
    end
      redirect_to invoices_path
  end
end
