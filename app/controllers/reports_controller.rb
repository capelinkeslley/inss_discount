# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @first_salary_range = Proponent.first_salary_range
    @second_salary_range = Proponent.second_salary_range
    @third_salary_range = Proponent.third_salary_range
    @fourth_salary_range = Proponent.fourth_salary_range
    @chart_data = [@first_salary_range.length, @second_salary_range.length,
                   @third_salary_range.length, @fourth_salary_range.length]
  end
end
