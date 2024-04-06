# frozen_string_literal: true

require 'rails_helper'

describe Platforms::CreateOrUpdate do
  subject { service.call }

  let(:service) { described_class.new(params: params) }

  context 'when creating a new platform' do
    let(:params) do
      {
        name: 'Wao Studio'
      }
    end

    it { is_expected.to be_success }

    it 'creates a new platform with correct data' do
      expect { subject }.to change(Platform, :count).by(1)
      platform = subject.success
      expect(platform.name).to eq(params[:name])
      expect(platform.client_id).to be_present
      expect(platform.public_key).to be_present
      expect(platform.private_key).to be_present
      private_key = OpenSSL::PKey::RSA.new(platform.private_key)
      expect(private_key.public_key.to_s).to eq(platform.public_key)
    end
  end

  context 'when updating an existing platform' do
    let(:platform) { create(:platform, name: 'WaoStudio') }
    let(:params) do
      {
        id: platform_id,
        name: 'Wao Studio'
      }
    end

    context 'when the platform is found' do
      let(:platform_id) { platform.id }

      it { is_expected.to be_success }

      it 'updates a new platform with correct data' do
        service.call
        platform.reload
        expect(platform.name).to eq('Wao Studio')
      end

      context 'when changing client_id' do
        let(:params) do
          {
            id: platform_id,
            client_id: 'abcd'
          }
        end

        it 'does not work' do
          service.call
          platform.reload
          expect(platform.client_id).not_to eq('abcd')
        end
      end
    end

    context 'when the platform is not found' do
      let(:platform_id) { 0 }

      it { is_expected.to be_failure }
    end
  end
end
