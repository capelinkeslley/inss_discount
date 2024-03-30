# frozen_string_literal: true

class UpdateProponentJob < ApplicationJob
  queue_as :default

  def perform(proponent_id:, params:)
    @proponent = Proponent.find_by(id: proponent_id)
    @params = params

    update_proponent if proponent.present?
  end

  private

  attr_reader :proponent, :params

  def update_proponent
    @proponent.update(params)
  end
end
