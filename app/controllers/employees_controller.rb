class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show ]

  def index
    @employees = Employee.all
  end

  def show
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      redirect_to @employee 
      flash[:notice] = "Employee was successfully created"      
    else
      render 'new'
      flash[:notice] = "Employee was not successfully created"
      
    end
  end

  private
    
    def set_employee
      @employee = Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit(:name, :surname, :phone, :email, :post, :salary, :department)
    end

end
