# frozen_string_literal: true

require 'rails_helper'

describe Users::GenerateToken do
  subject { service.call }

  let(:user) { create(:user) }
  let(:service) { described_class.new(user: user) }

  it 'returns a token that can be verified' do
    token = subject.success
    public_key = OpenSSL::PKey::RSA.new(user.platform.private_key)
    jwt_payload, = JWT.decode(token, public_key, true, algorithm: 'RS256')
    expect(jwt_payload).to eq(user.decorate.jwt_payload.with_indifferent_access)
  end
end
