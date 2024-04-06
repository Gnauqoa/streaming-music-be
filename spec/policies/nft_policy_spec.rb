# frozen_string_literal: true

require 'rails_helper'

describe NftPolicy do
  describe '#access?' do
    subject { described_class.new(user).access? }

    let(:platform) { create(:platform, scope: scope) }
    let(:user) { create(:user, platform: platform) }

    context 'when platform has nft scope' do
      let(:scope) { %w[abc nft] }

      it { is_expected.to be_truthy }
    end

    context 'when platform does not have nft scope' do
      let(:scope) { %w[abc wallet] }

      it { is_expected.to be_falsey }
    end
  end
end
