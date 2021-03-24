class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show edit update]

  def index
    @employees = Employee.all
  end

  def show
    phone_first = @employee.phone[0,3]
    phone_mid = @employee.phone[3,3]
    phone_last = @employee.phone[6,4]
    @employee.phone = "("+phone_first+")"+phone_mid+"-"+phone_last
  end

  def new
    @employee = Employee.new
  end

  def edit
  end

  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      redirect_to @employee
      flash[:notice] = "Employee was successfully created"      
    else
      render 'new'     
    end
  end

  def update
    if @employee.update(employee_params)
      redirect_to @employee
      flash[:notice] = "Employee was successfully updated." 
    else
      render 'edit'
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
