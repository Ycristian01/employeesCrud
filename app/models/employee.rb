require 'csv'

class Employee < ApplicationRecord
  validates :name, presence: true
  validates :surname, presence: true
  validates :phone, numericality: true
  validates :phone, length: { is: 10 }
  validates :email, uniqueness: true
  validates :salary, numericality: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 


  def self.to_csv
    attributes = %w{name surname phone email post salary department }

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |employee|
        csv << attributes.map{ |attr| employee.send(attr) }
      end
    end

  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      employee_hash = row.to_hash
      employee = find_or_create_by!(email: employee_hash['email'])
      employee.update(employee_hash)
    end
  end
  
end

