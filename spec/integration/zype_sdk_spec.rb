# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ZypeSDK do
  let(:app_key) { ENV['ZYPE_APP_KEY'] }
  let(:client_id) { ENV['ZYPE_CLIENT_ID'] }
  let(:client_secret) { ENV['ZYPE_CLIENT_SECRET'] } 


  before do
    ZypeSDK.configure do |config|
      config.app_key = app_key
      config.client_id = client_id
      config.client_secret = client_secret
    end
  end

  describe '#videos' do
    context 'with invalid app key' do
      let(:app_key) { 'invalid-app-key' }

      it 'returns an unauthorized response' do
        VCR.use_cassette('videos/invalid_app_key') do
          response = ZypeSDK.videos

          expect(response.status).to eq(:unauthorized)
          expect(response.content).to include('message' => 'Invalid or missing authentication.')
        end
      end
    end

    context 'with valid app key' do
      it 'returns a valid response' do
        VCR.use_cassette('videos/valid_app_key') do
          response = ZypeSDK.videos

          expect(response.status).to eq(:ok)
          expect(response.content).to have_key('response')
          expect(response.content).to have_key('pagination')
        end
      end
    end
  end

  describe '#video' do
    let(:video_id) { ENV['ZYPE_VALID_VIDEO_ID'] }
    
    context 'with invalid app key' do
      let(:app_key) { 'invalid-app-key' }

      it 'returns an unauthorized response' do
        VCR.use_cassette('video/invalid_app_key') do
          response = ZypeSDK.video(video_id)

          expect(response.status).to eq(:unauthorized)
          expect(response.content).to include('message' => 'Invalid or missing authentication.')
        end
      end
    end

    context 'with non existent video id' do
      let(:video_id) { 'non-existent' }

      it 'returns a not found response' do
        VCR.use_cassette('video/non_existent_id') do
          response = ZypeSDK.video(video_id)

          expect(response.status).to eq(:not_found)
          expect(response.content).to include('message' => 'Video not found')
        end
      end
    end

    context 'with valid existent video id' do
      it 'returns a valid response' do
        VCR.use_cassette('video/existent_id') do
          response = ZypeSDK.video(video_id)

          expect(response.status).to eq(:ok)
          expect(response.content).to have_key('response')
        end
      end
    end
  end

  describe '#login' do
    let(:username) { ENV['ZYPE_VALID_USERNAME'] }
    let(:password) { ENV['ZYPE_VALID_PASSWORD'] }

    context 'with invalid client id and client secrets' do
      let(:client_id) { 'invalid-client-id' }
      let(:client_secret) { 'invalid-client-secret' }

      it 'returns an unauthorized response' do
        VCR.use_cassette('login/invalid_client_id_and_secret') do
          response = ZypeSDK.login(username: username, password: password)

          expect(response.status).to eq(:unauthorized)
          expect(response.content).to include('error' => 'invalid_client')
        end
      end
    end

    context 'with invalid credentials' do
      let(:username) { 'invalid@example.com' }

      it 'returns an unauthorized response' do
        VCR.use_cassette('login/invalid_credentials') do
          response = ZypeSDK.login(username: username, password: password)

          expect(response.status).to eq(:unauthorized)
          expect(response.content).to include('error' => 'invalid_grant')
        end
      end
    end

    context 'with valid credentials, client id and client secret' do
      it 'returns a valid response' do
        VCR.use_cassette('login/valid_credentials') do
          response = ZypeSDK.login(username: username, password: password)

          expect(response.status).to eq(:ok)
          expect(response.content.keys).to include(
            'access_token', 'token_type', 'expires_in', 'refresh_token', 'scope', 'created_at'
          )
        end
      end
    end
  end
end
