# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Proponent, type: :model do
  describe 'associations' do
    it { should have_one(:address) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:document) }
    it { should validate_uniqueness_of(:document) }
    it { should validate_presence_of(:date_of_birth) }
    it { should validate_presence_of(:main_contact) }
    it { should validate_presence_of(:gross_salary) }

    describe 'validates document' do
      context 'when document is invalid' do
        let(:instance) { build(:proponent, document: '123123123') }

        it 'must return that it is invalid' do
          expect(instance).not_to be_valid
        end
      end

      context 'when document is valid' do
        let(:instance) { build(:proponent, document: CPF.generate) }

        it 'must return that it is valid' do
          expect(instance).to be_valid
        end
      end
    end

    describe 'validates main_contact' do
      context 'when main contact contains entre 8 and 15 caracters' do
        let(:instance) { build(:proponent, main_contact: Faker::PhoneNumber.cell_phone_in_e164) }

        it 'must return that it is invalid' do
          expect(instance).to be_valid
        end
      end

      context 'when main contact contains 7 caracters' do
        let(:instance) { build(:proponent, main_contact: '1234567') }

        it 'must return that it is invalid' do
          expect(instance).not_to be_valid
        end
      end

      context 'when main contact contains 15 caracters' do
        let(:instance) { build(:proponent, main_contact: '123456789123456') }

        it 'must return that it is invalid' do
          expect(instance).not_to be_valid
        end
      end
    end

    describe 'validates secondary_contact' do
      context 'when main contact contains entre 8 and 15 caracters' do
        let(:instance) { build(:proponent, secondary_contact: Faker::PhoneNumber.cell_phone_in_e164) }

        it 'must return that it is invalid' do
          expect(instance).to be_valid
        end
      end

      context 'when main contact contains 7 caracters' do
        let(:instance) { build(:proponent, secondary_contact: '1234567') }

        it 'must return that it is invalid' do
          expect(instance).not_to be_valid
        end
      end

      context 'when main contact contains 15 caracters' do
        let(:instance) { build(:proponent, secondary_contact: '123456789123456') }

        it 'must return that it is invalid' do
          expect(instance).not_to be_valid
        end
      end
    end

    describe 'validates date_of_birth' do
      context 'when date_of_birth is nil' do
        let(:instance) { build(:proponent, date_of_birth: nil) }

        it 'must return that it is invalid' do
          expect(instance).not_to be_valid
        end
      end

      context 'when date_of_birth is 15 years ago' do
        let(:instance) { build(:proponent, date_of_birth: 15.years.ago) }

        it 'must return that it is invalid' do
          expect(instance).not_to be_valid
        end
      end

      context 'when date_of_birth is 19 years ago' do
        let(:instance) { build(:proponent, date_of_birth: 19.years.ago) }

        it 'must return that it is valid' do
          expect(instance).to be_valid
        end
      end
    end
  end
end
