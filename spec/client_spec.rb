# frozen_string_literal: true

require 'spec_helper'

module ZypeSDK
  RSpec.describe Client do
    subject(:client) { described_class.new(config) }

    let(:config) do
      double(:config, app_key: app_key, client_id: client_id, client_secret: client_secret)
    end

    let(:app_key) { ENV['ZYPE_APP_KEY'] }
    let(:client_id) { ENV['ZYPE_CLIENT_ID'] }
    let(:client_secret) { ENV['ZYPE_CLIENT_SECRET'] }

    describe 'api' do
      it { is_expected.to respond_to(:login) }
      it { is_expected.to respond_to(:video) }
      it { is_expected.to respond_to(:videos) }
    end

    describe '#login' do
      subject(:login) { client.login(username: username, password: password) }

      let(:username) { ENV['ZYPE_VALID_USERNAME'] }
      let(:password) { ENV['ZYPE_VALID_PASSWORD'] }

      context 'with invalid client id and client secrets' do
        let(:client_id) { 'invalid-client-id' }
        let(:client_secret) { 'invalid-client-secret' }

        it 'returns an unauthorized response' do
          VCR.use_cassette('login/invalid_client_id_and_secret') do
            response = login

            expect(response.status).to eq(401)
            expect(response.content).to include('error' => 'invalid_client')
          end
        end
      end

      context 'with invalid credentials' do
        let(:username) { 'invalid@example.com' }

        it 'returns an unauthorized response' do
          VCR.use_cassette('login/invalid_credentials') do
            response = login

            expect(response.status).to eq(401)
            expect(response.content).to include('error' => 'invalid_grant')
          end
        end
      end

      context 'with valid credentials, client id and client secret' do
        it 'returns a valid response' do
          VCR.use_cassette('login/valid_credentials') do
            response = login

            expect(response.status).to eq(200)
            expect(response.content.keys).to include('access_token', 'token_type', 
              'expires_in', 'refresh_token', 'scope', 'created_at')
          end
        end
      end
    end
  end
end
