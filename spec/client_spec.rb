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
            expect(response.content.keys).to include(
              'access_token', 'token_type', 'expires_in', 'refresh_token', 'scope', 'created_at'
            )
          end
        end
      end
    end

    describe '#videos' do
      subject(:videos) { client.videos(params) }

      let(:params) { { page: 1 } }

      context 'with invalid app key' do
        let(:app_key) { 'invalid-app-key' }

        it 'returns an unauthorized response' do
          VCR.use_cassette('videos/invalid_app_key') do
            response = videos

            expect(response.status).to eq(401)
            expect(response.content).to include('message' => 'Invalid or missing authentication.')
          end
        end
      end

      context 'with valid app key' do
        it 'returns a valid response' do
          VCR.use_cassette('videos/valid_app_key') do
            response = videos

            expect(response.status).to eq(200)
            expect(response.content).to have_key('response')
            expect(response.content).to have_key('pagination')
          end
        end
      end

      context 'with valid app key and pagination params' do
        let(:params) { { page: 2 } }

        it 'returns a valid response' do
          VCR.use_cassette('videos/valid_app_key_and_params') do
            response = videos

            expect(response.status).to eq(200)
            expect(response.content).to have_key('response')
            expect(response.content).to have_key('pagination')
          end
        end
      end
    end

    describe '#video' do
      subject(:video) { client.video(video_id) }

      let(:video_id) { ENV['ZYPE_VALID_VIDEO_ID'] }

      context 'with invalid app key' do
        let(:app_key) { 'invalid-app-key' }

        it 'returns an unauthorized response' do
          VCR.use_cassette('video/invalid_app_key') do
            response = video

            expect(response.status).to eq(401)
            expect(response.content).to include('message' => 'Invalid or missing authentication.')
          end
        end
      end

      context 'with non existent video id' do
        let(:video_id) { 'non-existent' }

        it 'returns a not found response' do
          VCR.use_cassette('video/non_existent_id') do
            response = video

            expect(response.status).to eq(404)
            expect(response.content).to include('message' => 'Video not found')
          end
        end
      end

      context 'with valid existent video id' do
        it 'returns a valid response' do
          VCR.use_cassette('video/existent_id') do
            response = video

            expect(response.status).to eq(200)
            expect(response.content).to have_key('response')
          end
        end
      end
    end
  end
end
