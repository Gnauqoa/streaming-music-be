# frozen_string_literal: true

require 'rails_helper'

describe Users::Update do
  let(:password) { Faker::Internet.password }
  let(:user) { create(:user, password: password) }
  let(:service) { described_class.new(user: user, params: params) }

  context 'without changing password' do
    let(:params) do
      {
        email: Faker::Internet.email,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
      }
    end

    it 'updates the user successfully' do
      result = service.call
      expect(result).to be_success
      user.reload
      expect(user.email).to eq(params[:email])
      expect(user.first_name).to eq(params[:first_name])
      expect(user.last_name).to eq(params[:last_name])
    end
  end

  context 'with password' do
    let(:new_password) { Faker::Internet.password }
    let(:params) do
      {
        email: Faker::Internet.email,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        current_password: current_password,
        password: new_password
      }
    end

    context 'with the correct password' do
      let(:current_password) { password }

      it 'updates the user successfully' do
        result = service.call
        expect(result).to be_success
        user.reload
        expect(user.email).to eq(params[:email])
        expect(user.first_name).to eq(params[:first_name])
        expect(user.last_name).to eq(params[:last_name])
        expect(user.valid_password?(new_password)).to eq(true)
      end
    end

    context 'with an incorrect password' do
      let(:current_password) { Faker::Internet.password }

      it 'returns error' do
        result = service.call
        expect(result).to be_failure
        expect(result.failure).to eq(%i[update_failed invalid_password])
      end
    end
  end
end
