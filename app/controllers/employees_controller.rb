class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_employee!
  
  helper_method :employees_sort_column, :employees_sort_direction

  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.all.order("#{employees_sort_column} #{employees_sort_direction}").page params[:page]
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
    respond_to do |format|
      format.html { }
      format.json { render json: JSON.pretty_generate(JSON.parse(@employee.to_json)) }
    end
  end

  # GET /employees/new
  def new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render json: @employee, status: 201 }
      else
        format.html { render :new }
#        format.json { render json: @employee.errors, status: :unprocessable_entity }
        format.json { render json: {error: @employee.errors}, status: 400 }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render json: @employee, status: 200 }
      else
        format.html { render :edit }
#        format.json { render json: @employee.errors, status: :unprocessable_entity }
        format.json { render json: {error: @employee.errors}, status: 400 }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { 
#        redirect_to employees_url, notice: 'Employee was successfully destroyed.' 
        redirect_back fallback_location: employees_url, notice: 'Employee was successfully destroyed.'
        }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:FirstName, :LastName, :Email, :IsActive)
    end
    
    ### Secure the employees sort direction ###
    def employees_sort_direction
      %w[asc desc].include?(params[:employees_direction]) ?  params[:employees_direction] : "asc"
    end

    ### Secure the employees sort column name ###
    def employees_sort_column
      ["FirstName"].include?(params[:employees_column]) ? params[:employees_column] : "FirstName"
    end
end
