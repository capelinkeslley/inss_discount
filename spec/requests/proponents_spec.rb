# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProponentsController, type: :request do
  let(:valid_attributes) do
    attributes_for(:proponent)
  end
  let(:invalid_attributes) do
    attributes_for(:proponent, name: nil)
  end
  let(:user) { create(:user) }

  before { sign_in user }

  describe 'GET /index' do
    let!(:proponents) { create_list(:proponent, 10) }

    it 'renders a successful response' do
      get proponents_url

      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    context 'when proponent is valid' do
      let(:proponent) { create(:proponent) }

      it 'renders a successful response' do
        get proponent_url(proponent)

        expect(response).to be_successful
      end
    end

    context 'when proponent is invalid' do
      it 'renders a successful response' do
        get proponent_url(2)

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_proponent_url

      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    context 'when proponent is valid' do
      let(:proponent) { create(:proponent) }

      it 'renders a successful response' do
        get edit_proponent_url(proponent)

        expect(response).to be_successful
      end
    end

    context 'when proponent is invalid' do
      it 'renders a successful response' do
        get edit_proponent_url(2)

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Proponent' do
        expect do
          post proponents_url, params: { proponent: valid_attributes }
        end.to change(Proponent, :count).by(1)
      end

      it 'redirects to the created proponent' do
        post proponents_url, params: { proponent: valid_attributes }
        expect(response).to redirect_to(proponent_url(Proponent.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Proponent' do
        expect do
          post proponents_url, params: { proponent: invalid_attributes }
        end.to change(Proponent, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post proponents_url, params: { proponent: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    let(:proponent) { create(:proponent) }
    let(:new_attributes) do
      { name: 'updated name' }
    end

    context 'with valid parameters' do
      it 'updates the requested proponent' do
        patch proponent_url(proponent), params: { proponent: new_attributes }

        expect(response).to have_http_status(:found)
      end

      it 'updates the requested proponent' do
        patch proponent_url(proponent), params: { proponent: new_attributes }
        proponent.reload

        expect(proponent.name).to eq('updated name')
      end

      it 'redirects to the proponent' do
        patch proponent_url(proponent), params: { proponent: new_attributes }

        proponent.reload

        expect(response).to redirect_to(proponent_url(proponent))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        patch proponent_url(proponent), params: { proponent: invalid_attributes }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when proponent is invalid' do
      it 'must return http not_found status' do
        patch proponent_url(2), params: { proponent: new_attributes }

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'when proponent is valid' do
      let(:proponent) { create(:proponent) }

      it 'destroys the requested proponent' do
        expect do
          delete proponent_url(proponent)
        end.to change(Proponent, :count).by(0)
      end

      it 'redirects to the proponents list' do
        delete proponent_url(proponent)

        expect(response).to redirect_to(proponents_url)
      end
    end

    context 'when proponent is valid' do
      it 'must return http not_found status' do
        delete proponent_url(2)

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
