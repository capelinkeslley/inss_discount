# frozen_string_literal: true

module ProponentServices
  class Update
    include ActiveModel::Model

    def initialize(params, instance, callbacks)
      @params = params
      @instance = instance
      @callbacks = callbacks
    end

    def self.perform(params, instance, callbacks)
      new(params, instance, callbacks).update
    end

    def update
      instance.assign_attributes(params)

      if instance.valid?
        UpdateProponentJob.perform_later(proponent_id: instance.id, params:)

        callbacks[:success]&.call(instance)
      else
        callbacks[:error]&.call(instance)
      end
    end

    private

    attr_reader :params, :instance, :callbacks
  end
end
