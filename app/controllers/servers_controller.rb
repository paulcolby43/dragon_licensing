class ServersController < ApplicationController
  before_action :set_server, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_employee!

  # GET /servers
  # GET /servers.json
  def index
    if params[:q].blank?
      @servers = Server.all.order("Name ASC").page params[:page]
    else
      @query_string = "%#{params[:q]}%"
      @servers = Server.where("Name like ? OR MAC like ?", @query_string, @query_string).order("Name ASC").page params[:page]
    end
  end

  # GET /servers/1
  # GET /servers/1.json
  def show
    @tranact_account = @server.tranact_account
  end

  # GET /servers/new
  def new
    @server = Server.new
  end

  # GET /servers/1/edit
  def edit
  end

  # POST /servers
  # POST /servers.json
  def create
    @server = Server.new(server_params)

    respond_to do |format|
      if @server.save
        format.html { redirect_to @server, notice: 'Server was successfully created.' }
        format.json { render :show, status: :created, location: @server }
      else
        format.html { render :new }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /servers/1
  # PATCH/PUT /servers/1.json
  def update
    respond_to do |format|
      if @server.update(server_params)
        format.html { redirect_to @server, notice: 'Server was successfully updated.' }
        format.json { render :show, status: :ok, location: @server }
      else
        format.html { render :edit }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /servers/1
  # DELETE /servers/1.json
  def destroy
    @server.destroy
    respond_to do |format|
      format.html { 
#        redirect_to servers_url, notice: 'Server was successfully destroyed.' 
        redirect_back fallback_location: servers_url, notice: 'Server was successfully destroyed.'
        }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_server
      @server = Server.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def server_params
      params.require(:server).permit(:AccountID, :MAC, :Name, :EZCashKey, :JPEGgerKey, :CreateDate, :CreateUser, :ModifiedDate, :ModifiedUser, :ExpirationDate, :Active, :UseForJpegger, :NewJpegger)
    end
end
