class OrderLinesController < ApplicationController

  before_filter :find_order, :only => [:find_order_line, :index, :update, :remote_update, :update_order_information, :create]
  before_filter :find_order_line, :only => [:download]

  def find_order
    @order = Order.find(params[:order_id])
  end

  def find_order_line
    @order_line = OrderLine.find(params[:id])
  end

  def index
    @order_line = OrderLine.new
    if @order.order_lines.empty?
      flash[:notice]=t('order_line.no_order_lines')
    end
  end
  
  def new
    @order = Order.find(params[:order_id])
    @order_line = OrderLine.new
  end

  def create
#    @order = Order.find(params[:order_id])
    @order_line = @order.order_lines.build(params[:order_line])

    if @order_line.save
      @order = Order.find(params[:order_id])
      redirect_to order_order_lines_path(@order)
    else
      render :action => :new
    end

  end
  
  def edit
    error!
    @order = Order.find(params[:order_id])
    @order_line = @order.order_lines.find(params[:id])
  end
  
  def update
    @order = Order.find(params[:order_id])
    @order_line = @order.order_lines.find(params[:id])

    @order_line.update_attributes(params[:order_line])
    if @order_line.save
      redirect_to order_order_lines_path(@order)
    else
#      @order_line = OrderLine.new
      render :action => :edit
=begin
      responds_to_parent do
        render :update do |page|
          page.replace_html 'elements-list', 'error'
        end
      end
      flash[:error] = 'Error'
      render :action => :edit
=end
    end
  end
  
  def destroy
    @order = Order.find(params[:order_id])
    @order_line = OrderLine.find(params[:id])

    if @order_line.destroy
      redirect_to order_order_lines_url(@order)
    else
      flash[:error] = 'Error'
    end
  end

  def download
    send_file (url_for @order_line.image.url(:thumb)), :type => @order_line.image_content_type
  end
=begin
  def remote_update
    @order = Order.find(params[:order_id])
    @order_line = @order.order_lines.find(params[:order_line_id])
    @order_line.update_attributes(params[:order_line])
    if @order_line.save
      render :partial => 'remote_form_edit', :object => @order_line
    else
      render :partial => 'remote_form_edit', :object => @order_line
    end
  end
  def update_order_information
    render :partial => 'orders/show'
  end

=end
 end
