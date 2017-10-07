# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ZypeSDK do
  describe 'api' do
    it { expect(described_class).to respond_to(:configuration) }
  end

  describe '.configuration' do
    subject(:configure) do
      ZypeSDK.configuration do |config|
        config.app_key = app_key
        config.client_id = client_id
        config.client_secret = client_secret
      end
    end

    before { configure }

    context 'with valid configuration' do
      let(:app_key) { 'an-api-key' }
      let(:client_id) { 'a-client-id' }
      let(:client_secret) { 'a-client-secret' }

      it 'has app key configured' do
        expect(ZypeSDK.app_key).to eq(app_key)
      end

      it 'has client id configured' do
        expect(ZypeSDK.client_id).to eq(client_id)
      end

      it 'has client secret configured' do
        expect(ZypeSDK.client_secret).to eq(client_secret)
      end
    end

    context 'with invalid configuration' do
      let(:app_key) { nil }
      let(:client_id) { nil }
      let(:client_secret) { nil }

      it 'warns when app_key is not present' do
        expect { ZypeSDK.app_key }.to raise_error(ZypeSDK::Error)
          .with_message('Zype APP Key is required')
      end

      it 'warns when client_id is not present' do
        expect { ZypeSDK.client_id }.to raise_error(ZypeSDK::Error)
          .with_message('Zype Client id is required')
      end

      it 'warns when client_secret is not present' do
        expect { ZypeSDK.client_secret }.to raise_error(ZypeSDK::Error)
          .with_message('Zype Client secret is required')
      end
    end
  end
end
