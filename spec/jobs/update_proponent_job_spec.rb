# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateProponentJob, type: :job do
  subject { described_class.perform_now(proponent_id:, params:) }

  let(:params) do
    { name: 'John' }
  end
  let(:proponent) { create(:proponent) }

  context 'when proponent id is valid' do
    let(:proponent_id) { proponent.id }

    it 'must update name' do
      subject

      proponent.reload

      expect(proponent.name).to eq('John')
    end
  end

  context 'when proponent_id is invalid' do
    let(:proponent_id) { 100 }

    it 'must not update name' do
      subject

      proponent.reload

      expect(proponent.name).not_to eq('John')
    end
  end
end
