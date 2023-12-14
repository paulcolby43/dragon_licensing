class EzlicensesController < ApplicationController
#  before_action :set_ezlicense, only: [:show]
  before_action :authenticate_employee!, except: [:show]
  
  # GET /ezlicenses
  # GET /ezlicenses.json
  def index
  end

  # GET /ezlicenses/1
  # GET /ezlicenses/1.lic
  def show
#    @account = Account.find_by(AccountNumber: params[:id])
#    @licenses = @account.licenses unless @account.blank?
    @tranact_account = TranactAccount.find_by(Account: params[:id])
#    unless @account.blank? or @licenses.blank?
    unless @tranact_account.blank?
#      render plain: @licenses.map(&:to_csv).join
      render plain: @tranact_account.to_csv
    else
      render plain: 'Not found'
    end
  end

  # GET /ezlicenses/new
  def new
  end

  # GET /ezlicenses/1/edit
  def edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ezlicense
    end

end
