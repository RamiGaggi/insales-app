# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/app' do
  describe 'GET install' do
    let(:params) { { shop: 'xyz.insales.io', insales_id: 12, token: '123' }; }

    before do
      get api_install_path, params:
    end

    context 'when all required parameters are present' do
      it('responds with 200') do
        expect(response).to have_http_status(:ok)
      end

      it('creates account') { expect(Account.find_by(insales_id: params[:insales_id])).to be_present }
    end

    context 'when some required parameters are absent' do
      let(:params) { { insales_id: 333, token: '123' } }

      it('responds with 422') { expect(response).to have_http_status(:unprocessable_entity) }
      it('does not creates account') { expect(Account.find_by(insales_id: params[:insales_id])).not_to be_present }
    end
  end

  describe 'GET uninstall' do
    let(:token) { 'secret token' }
    let(:signed_token) { Insales::AppAuth.sign_with_app_secret(token) }
    let(:account) { create(:account, insales_application_password: signed_token) }
    let(:params) { { shop: account.insales_subdomain, insales_id: account.insales_id, token: } }

    before :each, unexpected: true do
      allow(account).to receive(:destroy).and_return(false)
      allow(Account).to receive(:find_by).and_return(account)
    end

    before { get api_uninstall_path, params: }

    context 'when all required parameters are present' do
      it('responds with 200') { expect(response).to have_http_status(:ok) }
      it('destroys account') { expect(Account.find_by(insales_id: account.insales_id)).not_to be_present }
    end

    context 'when account does not exist' do
      let(:params) { { insales_id: 12, shop: 'random' } }

      it('responds with 404') { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'when token is not verified' do
      let(:signed_token) { 'not verified password' }

      it('responds with 403') { expect(response).to have_http_status(:unprocessable_entity) }
      it('does not destroys account') { expect(Account.find_by(insales_id: account.insales_id)).to be_present }
    end

    context 'when application can not be uninstalled for other reasons', unexpected: true do
      it('responds with 422') { expect(response).to have_http_status(:unprocessable_entity) }
      it('does not destroys account') { expect(Account.find_by(insales_id: account.id)).to be_present }
    end
  end
end
