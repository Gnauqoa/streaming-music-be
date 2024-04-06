# frozen_string_literal: true

require 'rails_helper'

describe Users::Create do
  subject { service.call }

  let(:platform) { create(:platform) }
  let(:password) { Faker::Internet.password }
  let(:params) do
    {
      email: Faker::Internet.email,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      password: password
    }
  end
  let(:service) { described_class.new(params: params, platform: platform) }

  it { is_expected.to be_success }

  it 'creates a new user' do
    expect { subject }.to change(User, :count).by(1)
    user = subject.success
    expect(user.email).to eq(params[:email])
    expect(user.first_name).to eq(params[:first_name])
    expect(user.last_name).to eq(params[:last_name])
    expect(user.valid_password?(password)).to eq(true)
    expect(user.platform).to eq(platform)
  end
end
