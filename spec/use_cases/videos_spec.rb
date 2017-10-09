# frozen_string_literal: true

require 'spec_helper'

module ZypeSDK
  module UseCases
    RSpec.describe Videos do
      subject(:use_case) { described_class.new(page: page, client: client) }

      let(:client) { double(:client) }
      let(:page) { 1 }

      before do
        allow(client).to receive(:videos).with(page: page).and_return(response)
      end

      describe '#get' do
        subject(:videos) { use_case.get }

        context 'when an error happened' do
          let(:response) do
            double(:response, status: 401, content: content)
          end
          let(:content) { double(:message) }

          it 'does not return videos' do
            expect(videos.status).to eq(:unauthorized)
            expect(videos.content).to eq(content)
          end
        end

        context 'when no error happened' do
          let(:response) do
            double(:response, status: 200, content: content)
          end
          let(:content) { [double(:message, id: 1), double(:message, id: 2)] }

          it 'returns the videos' do
            expect(videos.status).to eq(:ok)
            expect(videos.content).to eq(content)
          end
        end

        context 'when no error happened and param were passed' do
          let(:page) { 2 }
          let(:response) do
            double(:response, status: 200, content: content)
          end
          let(:content) { [double(:message, id: 3), double(:message, id: 4)] }

          it 'returns the videos' do
            expect(videos.status).to eq(:ok)
            expect(videos.content).to eq(content)
          end
        end
      end
    end
  end
end
