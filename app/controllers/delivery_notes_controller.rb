class DeliveryNotesController < ApplicationController

  before_filter :find_order, :only => [:new]
  before_filter :find_delivery_note, :only => [:show, :print, :edit, :update]

  def find_delivery_note
    @delivery_note = DeliveryNote.find(params[:id])
  end

  def find_order
    @order = Order.find(params[:order_id])
  end

  def show
    @order = Order.find(@delivery_note.order_id)
  end

  def print
    @order = Order.find(@delivery_note.order_id)
    @with_header = params[:with_header].blank? ? false : true
    render :layout => 'print'
  end

  def index
    @delivery_notes = DeliveryNote.paginate(
      :per_page => PAGINATION,
      :page => params[:page]
    )

    if @delivery_notes.empty?
      flash[:notice] = t ('delivery_note.no_delivery_notes')
    end

  end

  def edit
    @order = Order.find(@delivery_note.order_id)
  end

  def new
    if @order.order_lines.blank?
      flash[:error] = t('order_line.no_order_lines')
      redirect_to orders_path
    end
    @delivery_note = DeliveryNote.find_or_initialize_by_order_id(params[:order_id])
    @delivery_note.code = @order.code
  end

  def create
    @delivery_note = DeliveryNote.new(params[:delivery_note])
    @order = Order.find(@delivery_note.order_id)
    if (@delivery_note.save)
      @order.created_delivery_note!
      flash[:success] = t ('delivery_note.create.success')
      redirect_to :action => :show, :id => @delivery_note.id
    else
      render :action => :new
#      redirect_to :action => :show, :id => @delivery_note.id
    end
  end

  def update
    if @delivery_note.update_attributes(params[:delivery_note])
      flash[:success] = t ('delivery_note.update.success')
      redirect_to :action => :show, :id => @delivery_note.id
    else
      render :action => :edit
    end
  end

  def destroy
    if @delivery_note.destroy
      flash[:success] = t('delivery_note.destroy.success')
    else
      flash[:error] = t('delivery_note.destroy.error')
    end
      redirect_to delivery_notes_path
  end
end
