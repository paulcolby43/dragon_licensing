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
    @account = Account.find_by(AccountNumber: params[:id])
    @licenses = @account.licenses unless @account.blank?
    unless @account.blank? or @licenses.blank?
      render plain: @licenses.map(&:to_csv).join
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
