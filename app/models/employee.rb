class Employee < ApplicationRecord
  validates :name, presence: true
  validates :surname, presence: true
  validates :phone, numericality: true
  validates :phone, length: { is: 11 }
  validates :email, uniqueness: true
  validates :salary, numericality: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
end
