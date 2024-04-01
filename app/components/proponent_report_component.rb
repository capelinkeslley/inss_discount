# frozen_string_literal: true

class ProponentReportComponent < ViewComponent::Base
  def initialize(title:, salary_range:)
    super
    @title = title
    @salary_range = salary_range
  end
end
