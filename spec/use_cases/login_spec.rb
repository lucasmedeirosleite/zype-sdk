# frozen_string_literal: true

require 'spec_helper'

module ZypeSDK
  module UseCases
    RSpec.describe Login do
      subject(:use_case) do
        described_class.new(username: username, password: password, client: client)
      end

      let(:client) { double(:client) }
      let(:username) { 'an-username' }
      let(:password) { 'a-password' }

      before do
        allow(client).to receive(:login)
          .with(username: username, password: password)
          .and_return(response)
      end

      describe '#login' do
        subject(:login) { use_case.login }

        context 'when user credentials invalid' do
          let(:response) do
            double(:response, status: 401, content: content)
          end
          let(:content) do
            double(:content)
          end

          it 'returns an unauthorized result' do
            expect(login.status).to eq(:unauthorized)
            expect(login.content).to eq(content)
          end
        end

        context 'when user credentials are valid' do
          let(:response) do
            double(:response, status: 200, content: content)
          end
          let(:content) do
            double(:content)
          end

          it 'returns a valid result' do
            expect(login.status).to eq(:ok)
            expect(login.content).to eq(content)
          end
        end
      end
    end
  end
end
