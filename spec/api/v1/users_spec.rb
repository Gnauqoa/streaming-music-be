# frozen_string_literal: true

require 'rails_helper'

describe V1::Users, type: :request do
  describe 'POST /v1/users' do
    let!(:platform) { create(:platform) }
    let(:path) { '/v1/users' }
    let(:params) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
      }
    end

    context 'when identify with host' do
      before do
        host! host
      end

      context 'when authorized' do
        let(:host) { 'localhost' }
        let(:service_double) do
          instance_double(::Users::Create, call: Success(build(:user)))
        end

        before do
          allow(::Users::Create).to receive(:new).and_return(service_double)
        end

        it 'calls the service' do
          post path, params: params
          pp response.body
          expect(::Users::Create).to have_received(:new).with(params: params, platform: platform)
        end

        context 'when service is succeeded' do
          it 'returns 201' do
            post path, params: params
            expect(response.status).to eq(201)
          end
        end

        context 'when service is failure' do
          let(:service_double) do
            instance_double(::Users::Create, call: Failure([:create_failed]))
          end

          it 'returns 422' do
            post path, params: params
            expect(response.status).to eq(422)
          end
        end
      end

      context 'when unauthorized' do
        let(:host) { '127.0.0.1' }

        before do
          allow(::Users::Create).to receive(:new)
        end

        it 'does not call the service' do
          post path, params: params
          expect(::Users::Create).not_to have_received(:new)
          expect(response.status).to eq(404)
        end
      end
    end

    context 'when identify with client id' do
      context 'when authorized' do
        let(:service_double) do
          instance_double(::Users::Create, call: Success(build(:user)))
        end

        before do
          allow(::Users::Create).to receive(:new).and_return(service_double)
        end

        it 'calls the service' do
          post path, params: params, headers: client_id_headers
          expect(::Users::Create).to have_received(:new).with(params: params, platform: platform)
        end

        context 'when service is succeeded' do
          it 'returns 201' do
            post path, params: params, headers: client_id_headers
            expect(response.status).to eq(201)
          end
        end

        context 'when service is failure' do
          let(:service_double) do
            instance_double(::Users::Create, call: Failure([:create_failed]))
          end

          it 'returns 422' do
            post path, params: params, headers: client_id_headers
            expect(response.status).to eq(422)
          end
        end
      end

      context 'when unauthorized' do
        before do
          allow(::Users::Create).to receive(:new)
        end

        it 'does not call the service' do
          post path, params: params
          expect(::Users::Create).not_to have_received(:new)
          expect(response.status).to eq(404)
        end
      end
    end
  end
end
