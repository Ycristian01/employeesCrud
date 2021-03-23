class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show ]

  def index
    @employees = Employee.all
  end

  def show
    
  end

  private
    
    def set_employee
      @employee = Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit(:name, :surname, :phone, :email, :post, :salary, :department)
    end

end
