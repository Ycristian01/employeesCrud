require 'csv'

class Employee < ApplicationRecord
  validates :name, presence: true
  validates :surname, presence: true
  validates :phone, numericality: true
  validates :phone, length: { is: 10 }
  validates :email, uniqueness: true
  #validates :salary, numericality: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 


  def self.to_csv
    attributes = %w{id name surname post department salary phone email}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |employee|
        csv << attributes.map{ |attr| employee.send(attr) }
      end
    end
    
  end
  
end

