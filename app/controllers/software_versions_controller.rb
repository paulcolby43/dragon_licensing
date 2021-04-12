class SoftwareVersionsController < ApplicationController
  before_action :set_software_version, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_employee!

  # GET /software_versions
  # GET /software_versions.json
  def index
    @software_versions = SoftwareVersion.all.order('SoftwareType asc')
  end

  # GET /software_versions/1
  # GET /software_versions/1.json
  def show
    @licenses = @software_version.licenses
  end

  # GET /software_versions/new
  def new
    @software_version = SoftwareVersion.new
  end

  # GET /software_versions/1/edit
  def edit
  end

  # POST /software_versions
  # POST /software_versions.json
  def create
    @software_version = SoftwareVersion.new(software_version_params)

    respond_to do |format|
      if @software_version.save
        format.html { redirect_to @software_version, notice: 'SoftwareVersion was successfully created.' }
        format.json { render :show, status: :created, location: @software_version }
      else
        format.html { render :new }
        format.json { render json: @software_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /software_versions/1
  # PATCH/PUT /software_versions/1.json
  def update
    respond_to do |format|
      if @software_version.update(software_version_params)
        format.html { redirect_to @software_version, notice: 'SoftwareVersionActivitiy was successfully updated.' }
        format.json { render :show, status: :ok, location: @software_version }
      else
        format.html { render :edit }
        format.json { render json: @software_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /software_versions/1
  # DELETE /software_versions/1.json
  def destroy
    @software_version.destroy
    respond_to do |format|
      format.html { 
#        redirect_to software_versions_url, notice: 'SoftwareVersion was successfully destroyed.' 
        redirect_back fallback_location: software_versions_url, notice: 'SoftwareVersion was successfully destroyed.'
        }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_software_version
      @software_version = SoftwareVersion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def software_version_params
      params.require(:software_version).permit(:SoftwareName, :CurrentVersion, :ReleaseDate, :SoftwareType, :IsSDX, :IsDefaultLicense)
    end
end
