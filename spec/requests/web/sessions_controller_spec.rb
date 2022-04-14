# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/sessions' do
  let(:account) { create(:account) }

  describe 'GET new' do
    before { get new_session_path }

    it('responds with 200') { expect(response).to have_http_status(:ok) }
  end

  describe 'POST create' do
    let(:params) { { insales_subdomain: account.insales_subdomain } }

    before { post session_path, params: }

    context 'when account is present' do
      it('responds with 200') { expect(response).to have_http_status(:found) }
    end

    context 'when account is absent' do
      let(:params) { { insales_subdomain: 'sadasd' } }

      it('rerenders page') { expect(response).to have_http_status(:ok) }
    end
  end

  describe 'POST destroy' do
    before do
      post test_session_path, params: { session: { account_id: 3 } }
      delete session_path
    end

    it('resets session') { expect(session[:account_id]).not_to be_present }
    it('responds with 302') { expect(response).to redirect_to(:new_session) }
  end
end
