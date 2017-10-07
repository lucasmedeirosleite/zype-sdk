# frozen_string_literal: true

require 'spec_helper'

module ZypeSDK
  module UseCases
    RSpec.describe Video do
      subject(:use_case) { described_class.new(video_id, client: client) }

      let(:client) { double(:client) }
      let(:video_id) { 'be1h23' }

      before do
        allow(client).to receive(:video).with(video_id).and_return(response)
      end

      describe '#get' do
        subject(:video) { use_case.get }
        
        context 'when unauthorized' do
          let(:response) do
            double(:response, status: 401, content: content)
          end
          let(:content) { double(:content) }

          it 'returns an unauthorized result' do
            expect(video.status).to eq(:unauthorized)
            expect(video.content).to eq(content)
          end
        end

        context 'when not found' do
          let(:response) do
            double(:response, status: 404, content: content)
          end
          let(:content) { double(:content) }

          it 'returns an unauthorized result' do
            expect(video.status).to eq(:not_found)
            expect(video.content).to eq(content)
          end
        end

        context 'when found' do
          let(:response) do
            double(:response, status: 200, content: content)
          end
          let(:content) { double(:content) }

          it 'returns an unauthorized result' do
            expect(video.status).to eq(:ok)
            expect(video.content).to eq(content)
          end
        end
      end
    end
  end
end
