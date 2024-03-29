# frozen_string_literal: true

module ProponentServices
  class CalculateDiscount
    def initialize(gross_salary)
      @gross_salary = gross_salary
    end

    def self.perform(gross_salary:)
      new(gross_salary).call
    end

    def call
      calculate(first_rate)

      @discount
    end

    private

    attr_reader :gross_salary

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
  end
end