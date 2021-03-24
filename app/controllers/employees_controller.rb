class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show edit update]

  def index
    @employees = Employee.all

    respond_to do |format|
      format.html
      format.csv { send_data @employees.to_csv, filename: "employeesx -#{Date.today}.csv" }
    end
  end

  def import 
    Employee.import(params[:file])
    redirect_to root_url, notice: "Employees imported"

  end

  def show
    phone_first = @employee.phone[0,3]
    phone_mid = @employee.phone[3,3]
    phone_last = @employee.phone[6,4]
    @employee.phone = "("+phone_first+")"+phone_mid+"-"+phone_last
    
    if @employee.salary[0,1]=="$" 
      @employee.salary =  @employee.salary[1, @employee.salary.size]
    end
    puts @employee.salary.size
    whole, decimal = @employee.salary.to_s.split(".")
    whole_with_commas = whole.chars.to_a.reverse.each_slice(3).map(&:join).join(".").reverse
    @employee.salary= [whole_with_commas, decimal].compact.join(",")
    @employee.salary = "$" + @employee.salary
  end

  def export_csv
    employee_csv = Employee.find_by_sql("select * from employees_list limit 10")
    respond_to do |format|
      format.html
      format.csv { send_data employee_csv.as_csv }
    end
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
