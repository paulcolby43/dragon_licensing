class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]
#  before_action :authenticate_employee!
  
  helper_method :devices_sort_column, :devices_sort_direction

  # GET /devices
  # GET /devices.json
  def index
    @devices = Device.all.order("#{devices_sort_column} #{devices_sort_direction}").page params[:page]
    respond_to do |format|
      format.html { }
      format.json { render json: JSON.pretty_generate(JSON.parse(@devices.to_json)) }
    end
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
    respond_to do |format|
      format.html { }
      format.json { render json: JSON.pretty_generate(JSON.parse(@device.to_json)) }
    end
  end

  # GET /devices/new
  def new
  end

  # GET /devices/1/edit
  def edit
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(device_params)

    respond_to do |format|
      if @device.save
        format.html { redirect_to @device, notice: 'Device was successfully created.' }
        format.json { render json: @device, status: 201 }
      else
        format.html { render :new }
#        format.json { render json: @device.errors, status: :unprocessable_entity }
        format.json { render json: {error: @device.errors}, status: 400 }
      end
    end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    respond_to do |format|
      if @device.update(device_params)
        format.html { redirect_to @device, notice: 'Device was successfully updated.' }
        format.json { render json: @device, status: 200 }
      else
        format.html { render :edit }
#        format.json { render json: @device.errors, status: :unprocessable_entity }
        format.json { render json: {error: @device.errors}, status: 400 }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    if @device
      @device.destroy
      render json: {message: 'Device successfully deleleted.'}, status: 204
    else
      render error: {error: 'Unable to delete Device.'}, status: 400
    end
    
    @device.destroy
    respond_to do |format|
      format.html { 
#        redirect_to devices_url, notice: 'Device was successfully destroyed.' 
        redirect_back fallback_location: devices_url, notice: 'Device was successfully destroyed.'
        }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def device_params
      params.require(:device).permit(:description, :address, :license_guid)
    end
    
    ### Secure the devices sort direction ###
    def devices_sort_direction
      %w[asc desc].include?(params[:devices_direction]) ?  params[:devices_direction] : "asc"
    end

    ### Secure the devices sort column name ###
    def devices_sort_column
      ["description"].include?(params[:devices_column]) ? params[:devices_column] : "description"
    end
end
