class LicensesController < ApplicationController
  before_action :set_license, only: [:show, :edit, :update, :destroy]

  # GET /licenses
  # GET /licenses.json
  def index
    @licenses = License.all
  end

  # GET /licenses/1
  # GET /licenses/1.json
  def show
    @software_version = @license.software_version
    @account = @license.account
  end

  # GET /licenses/new
  def new
    @license = License.new
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
      format.html { redirect_to licenses_url, notice: 'License was successfully destroyed.' }
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
      params.require(:license).permit(:name, :title, :content)
    end
end
