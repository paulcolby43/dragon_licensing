class LicensesController < ApplicationController
  before_action :set_license, only: [:show, :edit, :update, :destroy]
  
  helper_method :licenses_sort_column, :licenses_sort_direction

  # GET /licenses
  # GET /licenses.json
  def index
    @licenses = License.all.order("#{licenses_sort_column} #{licenses_sort_direction}")
  end

  # GET /licenses/1
  # GET /licenses/1.json
  def show
    @software_version = @license.software_version
    @account = @license.account
  end

  # GET /licenses/new
  def new
#    @account = Account.find(params[:account_id]) unless params[:account_id].blank?
    @license = License.new(AccountHeadId: params[:account_id])
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
        format.json { render :show, status: :created, location: @license }
      else
        format.html { render :new }
        format.json { render json: @license.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /licenses/1
  # PATCH/PUT /licenses/1.json
  def update
    respond_to do |format|
      if @license.update(license_params)
        format.html { redirect_to @license, notice: 'LicenseActivitiy was successfully updated.' }
        format.json { render :show, status: :ok, location: @license }
      else
        format.html { render :edit }
        format.json { render json: @license.errors, status: :unprocessable_entity }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_license
      @license = License.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def license_params
      params.require(:license).permit(:AccountHeadId, :SoftwareVersionId, :ExpireDate, :DaysBetweenUpdate, :AutoUpdate, :IsDemoLicense, :IsSingleUser)
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
