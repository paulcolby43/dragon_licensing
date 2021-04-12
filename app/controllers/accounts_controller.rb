class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_employee!

  # GET /accounts
  # GET /accounts.json
  def index
    if params[:q].blank?
      @accounts = Account.all.order("YardName ASC").page params[:page]
    else
      @query_string = "%#{params[:q]}%"
      @accounts = Account.where("AccountNumber like ? OR YardName like ? OR Notes like ? OR Address like ? OR City like ? OR State like ? OR Zip like ?", @query_string, @query_string, @query_string, @query_string, @query_string, @query_string, @query_string).order("YardName ASC").page params[:page]
    end
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    @licenses = @account.licenses
#    @account_activities = @account.account_activities
    @account_activities = @account.account_activities.order("DateCreated DESC").page params[:page]
    respond_to do |format|
      format.html {}
      format.json { 
        render json: JSON.pretty_generate(JSON.parse(@account.to_json(include: :licenses)))
#        rescue ActiveRecord::RecordNotFound
#          head :not_found
        }
    end
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
#        format.json { render :show, status: :created, location: @account }
#        format.json {render json: @account, status: 201}
        format.json {
          render json: JSON.pretty_generate(JSON.parse(@account.to_json)), status: 201
        }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'AccountActivitiy was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { 
#        redirect_to accounts_url, notice: 'Account was successfully destroyed.' 
        redirect_back fallback_location: accounts_url, notice: 'Account was successfully destroyed.'
        }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:AccountNumber, :ScrapDragonClassic, :ScrapDragonX, :Address, :City, :State, :Address2, :Zip, :PhoneNumber, :YardName, :IsActive, :Notes, :IsSuspended)
    end
end
