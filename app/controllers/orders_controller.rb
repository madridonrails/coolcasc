class OrdersController < ApplicationController
  

  before_filter :find_order, :only => [:show, :edit, :update, :destroy, :create_delivery_note, :create_invoice, :deal, :cancel, :print, :issue_invoice, :cancel_issue_invoice]
#  before_filter :login_required

  def find_order
    @order = Order.find(params[:id])
  end


  def index

    @orders = Order.paginate(
      :per_page => PAGINATION,
      :page => params[:page]
    )
    if @orders.empty?
      flash[:notice] = t('order.no_orders')
    end

  end

  def print
    @with_header = params[:with_header].blank? ? false : true
    render :layout => 'print'
  end

  def edit
    @order_lines = OrderLine.find_by_order_id(@order.id)
  end

  def show
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(params[:order])
    if (@order.save)
#      flash[:notice] = t('order.created.success')
      redirect_to(@order)
    else
      render :action => "new"
    end
  end

  def update
    if @order.update_attributes(params[:order])
#        flash[:notice] = 'Order was successfully updated.'
      redirect_to(@order)
    else
      render :action => "edit"
    end
  end

  def destroy
    @order.destroy
    redirect_to(orders_url)   
  end
  
  def create_delivery_note
    @order.create_delivery_note!
    if @order.save
      flash[:success] = t('order.events.success.create_delivery_note')
    else
      flash[:error] = t('order.events.error.create_delivery_note')
    end

    redirect_to orders_path
  end

  def create_invoice
    @order.create_invoice!
    if @order.save
      flash[:success] = t('order.events.success.create_invoice')
    else
      flash[:error] = t('order.events.error.create_invoice')
    end

    redirect_to orders_path
  end

  def generate
    @order.generate!
    if @order.save
      flash[:success] = t('order.events.success.generate')
    else
      flash[:error] = t('order.events.error.generate')
    end
    redirect_to orders_path
  end 
  
  def cancel
    @order.cancel!
    if @order.save
      flash[:success] = t('order.events.success.cancel')
    else
      flash[:error] = t('order.events.error.cancel')
    end
    redirect_to orders_path
  end 

  def deal
    @order.deal!
    if @order.save
      flash[:success] = t('order.events.success.deal')
    else
      flash[:error] = t('order.events.error.deal')
    end
    redirect_to orders_path
  end 

  def issue_invoice
    @order.issue_invoice!
    @order.save
    redirect_to orders_path
  end

  def cancel_issue_invoice
    @order.cancel_issue_invoice!
    @order.save
    redirect_to orders_path
  end


end
