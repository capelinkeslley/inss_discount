# frozen_string_literal: true

class CalculateDiscountJob < ApplicationJob
  queue_as :default

  def perform(proponent_id:)
    @proponent = Proponent.find_by(id: proponent_id)

    update_proponent if proponent.present?
  end

  private

  attr_reader :proponent

  def update_proponent
    calculate(first_rate)

    proponent.update(discount: @discount, net_salary: gross_salary - @discount)
  end

  def calculate(function)
    function
  end

  def first_rate
    @discount = ((1_045.0 * 7.5) / 100.0).round(2)

    calculate(second_rate) if gross_salary > 1_045.0
  end

  def second_rate
    salary = gross_salary > 2_089.6 ? 2_089.6 - 1_045 : gross_salary - 1_045

    @discount += ((salary * 9) / 100.0).round(2)

    calculate(third_rate) if gross_salary > 2_089.6
  end

  def third_rate
    salary = gross_salary > 3_134.40 ? 3_134.40 - 2_089.6 : gross_salary - 2_089.6

    @discount += ((salary * 12) / 100.0).round(2)

    calculate(fourth_rate) if gross_salary > 3_134.4 && gross_salary <= 6_601.06
  end

  def fourth_rate
    salary = gross_salary > 6_101.06 ? 6_101.06 - 3_134.4 : gross_salary - 3_134.4

    @discount += ((salary * 14) / 100.0).round(2)
  end

  def gross_salary
    @gross_salary ||= proponent.gross_salary
  end
end
