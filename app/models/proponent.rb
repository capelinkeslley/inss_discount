# frozen_string_literal: true

class Proponent < ApplicationRecord
  validates :name, :document, :date_of_birth, :main_contact, :gross_salary, presence: true
  validates :main_contact, numericality: { only_integer: true }, length: { in: 8..14 }
  validates :secondary_contact, numericality: { only_integer: true }, length: { in: 8..14 }, allow_blank: true
  validates :document, uniqueness: true, length: { is: 11 }
  validate :validate_document, if: :document
  validate :validate_date_of_birth, if: :date_of_birth

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
