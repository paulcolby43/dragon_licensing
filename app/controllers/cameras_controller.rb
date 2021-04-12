class CamerasController < ApplicationController
  before_action :set_camera, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_employee!
  
  helper_method :cameras_sort_column, :cameras_sort_direction

  # GET /cameras
  # GET /cameras.json
  def index
    @cameras = Camera.all.order("#{cameras_sort_column} #{cameras_sort_direction}").page params[:page]
    respond_to do |format|
      format.html { }
      format.json { render json: JSON.pretty_generate(JSON.parse(@cameras.to_json)) }
    end
  end

  # GET /cameras/1
  # GET /cameras/1.json
  def show
    respond_to do |format|
      format.html { }
      format.json { render json: JSON.pretty_generate(JSON.parse(@camera.to_json)) }
    end
  end

  # GET /cameras/new
  def new
  end

  # GET /cameras/1/edit
  def edit
  end

  # POST /cameras
  # POST /cameras.json
  def create
    @camera = Camera.new(camera_params)

    respond_to do |format|
      if @camera.save
        format.html { redirect_to @camera, notice: 'Camera was successfully created.' }
        format.json { render json: @camera, status: 201 }
      else
        format.html { render :new }
#        format.json { render json: @camera.errors, status: :unprocessable_entity }
        format.json { render json: {error: @camera.errors}, status: 400 }
      end
    end
  end

  # PATCH/PUT /cameras/1
  # PATCH/PUT /cameras/1.json
  def update
    respond_to do |format|
      if @camera.update(camera_params)
        format.html { redirect_to @camera, notice: 'Camera was successfully updated.' }
        format.json { render json: @camera, status: 200 }
      else
        format.html { render :edit }
#        format.json { render json: @camera.errors, status: :unprocessable_entity }
        format.json { render json: {error: @camera.errors}, status: 400 }
      end
    end
  end

  # DELETE /cameras/1
  # DELETE /cameras/1.json
  def destroy
    if @camera
      @camera.destroy
      render json: {message: 'Camera successfully deleleted.'}, status: 204
    else
      render error: {error: 'Unable to delete Camera.'}, status: 400
    end
    
    @camera.destroy
    respond_to do |format|
      format.html { 
#        redirect_to cameras_url, notice: 'Camera was successfully destroyed.' 
        redirect_back fallback_location: cameras_url, notice: 'Camera was successfully destroyed.'
        }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_camera
      @camera = Camera.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def camera_params
      params.require(:camera).permit(:name, :ip_address, :license_guid)
    end
    
    ### Secure the cameras sort direction ###
    def cameras_sort_direction
      %w[asc desc].include?(params[:cameras_direction]) ?  params[:cameras_direction] : "asc"
    end

    ### Secure the cameras sort column name ###
    def cameras_sort_column
      ["name"].include?(params[:cameras_column]) ? params[:cameras_column] : "name"
    end
end
