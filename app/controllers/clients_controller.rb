class ClientsController < ApplicationController

  def index
    @clients = Client.paginate(
      :page => params[:page],
      :per_page => PAGINATION
    )
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(params[:client])
    if @client.save
      redirect_to clients_path
    else
      render :action => :new
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    @client.update_attributes(params[:client])
    if @client.save
      redirect_to clients_path
    else
      render :action => :edit
    end
  end

  def destroy
    @client = Client.find(params[:id])
    if @client.destroy
      redirect_to clients_path
    end
  end

  def show
    @client = Client.find(params[:id])
  end

end
