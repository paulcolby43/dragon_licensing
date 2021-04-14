class LicensesController < ApplicationController
  before_action :set_license, only: [:show, :edit, :update, :destroy, :file_download]
  before_action :authenticate_employee!, except: [:index, :show, :file_download]
  
  helper_method :licenses_sort_column, :licenses_sort_direction

  # GET /licenses
  # GET /licenses.json
  def index
    @licenses = License.all.order("#{licenses_sort_column} #{licenses_sort_direction}").page params[:page]
  end

  # GET /licenses/1
  # GET /licenses/1.json
  def show
    @software_version = @license.software_version
    @account = @license.account
    respond_to do |format|
      format.html { }
      format.json { render json: JSON.pretty_generate(JSON.parse(@license.to_json)) }
    end
  end

  # GET /licenses/new
  def new
#    @account = Account.find(params[:account_id]) unless params[:account_id].blank?
    @license = License.new(AccountHeadId: params[:account_id])
    @license.devices.build
  end

  # GET /licenses/1/edit
  def edit
  end

  # POST /licenses
  # POST /licenses.json
  def create
    @license = License.new(license_params)

    respond_to do |format|
      if @license.save
        format.html { redirect_to @license, notice: 'License was successfully created.' }
        format.json { render json: @license, status: 201 }
      else
        format.html { render :new }
#        format.json { render json: @license.errors, status: :unprocessable_entity }
        format.json { render json: {error: @license.errors}, status: 400 }
      end
    end
  end

  # PATCH/PUT /licenses/1
  # PATCH/PUT /licenses/1.json
  def update
    respond_to do |format|
      if @license.update(license_params)
        format.html { redirect_to @license, notice: 'License was successfully updated.' }
        format.json { render json: @license, status: 200 }
      else
        format.html { render :edit }
#        format.json { render json: @license.errors, status: :unprocessable_entity }
        format.json { render json: {error: @license.errors}, status: 400 }
      end
    end
  end

  # DELETE /licenses/1
  # DELETE /licenses/1.json
  def destroy
    @license.destroy
    respond_to do |format|
      format.html { 
#        redirect_to licenses_url, notice: 'License was successfully destroyed.' 
        redirect_back fallback_location: licenses_url, notice: 'License was successfully destroyed.'
        }
      format.json { head :no_content }
    end
  end
  
  # GET /licenses/1/file_download
  def file_download
    send_data @license.to_csv, filename: "License#{@license.Id}.lic"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_license
      @license = License.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def license_params
      params.require(:license).permit(:AccountHeadId, :SoftwareVersionId, :ExpireDate, :DaysBetweenUpdate, :AutoUpdate, :IsDemoLicense, :IsSingleUser, :number_of_devices, :number_of_subnets,
        :number_of_cameras, :jpegger_mac_address, :ezcash_mac_address,
        devices_attributes: [:id, :description, :address, :license_guid, :_destroy], cameras_attributes: [:id, :name, :ip_address, :license_guid, :_destroy])
    end
    
    ### Secure the licenses sort direction ###
    def licenses_sort_direction
      %w[asc desc].include?(params[:licenses_direction]) ?  params[:licenses_direction] : "asc"
    end

    ### Secure the licenses sort column name ###
    def licenses_sort_column
      ["SoftwareVersionId", "AccountHeadId", "ExpireDate", "DaysBetweenUpdate", "AutoUpdate", "IsDemoLicense", "IsSingleUser"].include?(params[:licenses_column]) ? params[:licenses_column] : "SoftwareVersionId"
    end
end
