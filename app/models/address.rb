# frozen_string_literal: true

class Address < ApplicationRecord
  validates :street, :number, :neighborhood, :city, :state, :zip_code, presence: true

  belongs_to :proponent
end
