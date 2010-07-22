class SalesManagersController < ApplicationController

  def index
    @sales_managers = SalesManager.paginate(
      :page => params[:page],
      :per_page => PAGINATION
    )
  end

  def new
    @sales_manager = SalesManager.new
  end

  def create
    @sales_manager = SalesManager.new(params[:sales_manager])
    if @sales_manager.save
      redirect_to sales_managers_path
    else
      render :action => :new
    end
  end

  def edit
    @sales_manager = SalesManager.find(params[:id])
  end

  def update
    @sales_manager = SalesManager.find(params[:id])
    @sales_manager.update_attributes(params[:sales_manager])
    if @sales_manager.save
      redirect_to sales_managers_path
    else
      render :action => :edit
    end
  end

  def destroy
    @sales_manager = SalesManager.find(params[:id])
    if @sales_manager.destroy
      redirect_to sales_managers_path
    end
  end

  def show
    @sales_manager = SalesManager.find(params[:id])
  end

end
