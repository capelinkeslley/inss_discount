# frozen_string_literal: true

class Proponent < ApplicationRecord
  validates :name, :document, :date_of_birth, :main_contact, :gross_salary, presence: true
  validates :main_contact, numericality: { only_integer: true }, length: { in: 8..14 }
  validates :secondary_contact, numericality: { only_integer: true }, length: { in: 8..14 }, allow_blank: true
  validates :document, uniqueness: true, length: { is: 11 }
  validate :validate_document, if: :document
  validate :validate_date_of_birth, if: :date_of_birth

  has_one :address, dependent: :destroy

  accepts_nested_attributes_for :address

  scope :first_salary_range, lambda {
    where('gross_salary <= :min_value', min_value: 1_045.0)
  }

  scope :second_salary_range, lambda {
    where('gross_salary > :min_value AND gross_salary <= :max_value', min_value: 1_045.1, max_value: 2_089.6)
  }

  scope :third_salary_range, lambda {
    where('gross_salary > :min_value AND gross_salary <= :max_value', min_value: 2_089.61, max_value: 3_134.4)
  }

  scope :fourth_salary_range, lambda {
    where('gross_salary > :min_value AND gross_salary <= :max_value', min_value: 3_134.41, max_value: 6_101.06)
  }

  private

  def validate_document
    return if CPF.valid?(document)

    errors.add(:document, :invalid)
  end

  def validate_date_of_birth
    return if date_of_birth.to_date <= 18.years.ago.to_date
    errors.add(:date_of_birth, :invalid)

  end
end
