class TranactAccountsController < ApplicationController
  before_action :set_tranact_account, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_employee!

  # GET /tranact_accounts
  # GET /tranact_accounts.json
  def index
    if params[:q].blank?
      @tranact_accounts = TranactAccount.where.not(Name: [nil, '']).where.not(Account: [nil, '']).order("Name ASC").page params[:page]
    else
      @query_string = "%#{params[:q]}%"
      @tranact_accounts = TranactAccount.where("Account like ? OR Name like ?", @query_string, @query_string).order("Name ASC").page params[:page]
    end
  end

  # GET /tranact_accounts/1
  # GET /tranact_accounts/1.json
  def show
    respond_to do |format|
      format.html {
#        @software_locations = @tranact_account.software_locations
#        @devices = @tranact_account.devices
        @servers = @tranact_account.servers
#        @customers = @tranact_account.customers
      }
      format.json { 
        render json: JSON.pretty_generate(JSON.parse(@tranact_account.to_json(include: :licenses)))
#        rescue ActiveRecord::RecordNotFound
#          head :not_found
        }
    end
  end

  # GET /tranact_accounts/new
  def new
    @tranact_account = TranactAccount.new
  end

  # GET /tranact_accounts/1/edit
  def edit
  end

  # POST /tranact_accounts
  # POST /tranact_accounts.json
  def create
    @tranact_account = TranactAccount.new(tranact_account_params)

    respond_to do |format|
      if @tranact_account.save
        format.html { redirect_to @tranact_account, notice: 'TranactAccount was successfully created.' }
        format.json {
          render json: JSON.pretty_generate(JSON.parse(@tranact_account.to_json)), status: 201
        }
      else
        format.html { render :new }
        format.json { render json: @tranact_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tranact_accounts/1
  # PATCH/PUT /tranact_accounts/1.json
  def update
    respond_to do |format|
      if @tranact_account.update(tranact_account_params)
        format.html { redirect_to @tranact_account, notice: 'TranactAccount was successfully updated.' }
        format.json { render :show, status: :ok, location: @tranact_account }
      else
        format.html { render :edit }
        format.json { render json: @tranact_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tranact_accounts/1
  # DELETE /tranact_accounts/1.json
  def destroy
    @tranact_account.destroy
    respond_to do |format|
      format.html { 
#        redirect_to tranact_accounts_url, notice: 'TranactAccount was successfully destroyed.' 
        redirect_back fallback_location: tranact_accounts_url, notice: 'TranactAccount was successfully destroyed.'
        }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tranact_account
      @tranact_account = TranactAccount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tranact_account_params
      params.require(:tranact_account).permit(:Name, :JPEGger, :JPEGgerExpDate, :JPEGgerLicType, :JPEGgerQty, :JPEGgerDemo, :JPEGgerLock, :Dog, :DogExpDate, :DogUsers, :DogDemo, :EZCash, 
        :EZCashExpDate, :EZCashDevices, :EZCashDemo, :EZCashLock, :CreateDate, :CreateUser, :ModifiedDate, :ModifiedUser, :Active, :LicenseIntervalMonths, :LocationID)
    end
end
