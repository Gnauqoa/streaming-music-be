# frozen_string_literal: true

require 'rails_helper'

describe V1::Platforms, type: :request do
  describe 'POST /v1/platforms' do
    let(:user) { create(:user) }
    let(:path) { '/v1/platforms' }
    let(:params) do
      {
        name: 'New Platform'
      }
    end

    context 'when authorized' do
      let(:service_double) do
        instance_double(::Platforms::CreateOrUpdate, call: Success(build(:platform)))
      end

      before do
        grant_authorization(:platform, :create?)
        allow(::Platforms::CreateOrUpdate).to receive(:new).and_return(service_double)
      end


      it 'calls the service' do
        post path, params: params, headers: jwt_headers
        expect(::Platforms::CreateOrUpdate).to have_received(:new).with(params: params)
      end

      context 'when service is succeeded' do
        it 'returns 201' do
          post path, params: params, headers: jwt_headers
          expect(response.status).to eq(201)
        end
      end

      context 'when service is failure' do
        let(:service_double) do
          instance_double(::Platforms::CreateOrUpdate, call: Failure([:platform_not_found]))
        end

        it 'returns 422' do
          post path, params: params, headers: jwt_headers
          expect(response.status).to eq(422)
        end
      end
    end

    context 'when unauthorized' do
      before do
        revoke_authorization(:platform, :create?)
        allow(::Platforms::CreateOrUpdate).to receive(:new)
      end

      it 'does not call the service' do
        post path, params: params, headers: jwt_headers
        expect(::Platforms::CreateOrUpdate).not_to have_received(:new)
        expect(response.status).to eq(403)
      end
    end
  end
end
