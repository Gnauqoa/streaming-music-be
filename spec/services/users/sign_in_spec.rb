# frozen_string_literal: true

require 'rails_helper'

describe Users::SignIn do
  subject { service.call }

  let(:platform) { create(:platform) }
  let(:wallet_address) { Eth::Key.new.address.to_s }
  let!(:user) { create(:user, password: password, wallet_address: wallet_address, platform: platform) }
  let(:email) { user.email }
  let(:password) { Faker::Internet.password }
  let(:login_password) { password }
  let(:service) { described_class.new(email: email, wallet_address: wallet_address, password: login_password, platform: platform) }

  context 'email and wallet_address empty' do
    let(:email) { nil }
    let(:wallet_address) { nil }

    it { is_expected.not_to be_success }
  end

  context 'with the correct password' do
    let(:service_double) do
      instance_double(::Users::GenerateToken, call: Success('token'))
    end

    before do
      allow(::Users::GenerateToken).to receive(:new).and_return(service_double)
    end

    context 'with email' do
      let(:wallet_address) { nil }

      it { is_expected.to be_success }
      it { expect(subject.success).to eq('token') }

      it 'calls the GenerateToken service' do
        service.call

        expect(::Users::GenerateToken).to have_received(:new).with(user: user)
        expect(service_double).to have_received(:call)
      end
    end

    context 'with wallet_address' do
      let(:email) { nil }

      it { is_expected.to be_success }
      it { expect(subject.success).to eq('token') }

      it 'calls the GenerateToken service' do
        service.call

        expect(::Users::GenerateToken).to have_received(:new).with(user: user)
        expect(service_double).to have_received(:call)
      end
    end
  end

  context 'with an incorrect password' do
    let(:login_password) { Faker::Internet.password }

    it { is_expected.to be_failure }
    it { expect(subject.failure).to eq([:invalid_password, 'Invalid password']) }
  end
end
