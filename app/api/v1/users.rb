# frozen_string_literal: true

module V1
  class Users < PublicBase
    resources :users do
      desc 'This API allows registration to the platform',
           summary: 'Register',
           success: { code: 201, model: Entities::V1::AuthenticationResponse },
           headers: {
             'Client-ID' => {
               description: 'The platform client ID',
               required: true
             }
           }
      params do
        requires :email, type: String, regexp: URI::MailTo::EMAIL_REGEXP,
                         desc: 'The unique login email', documentation: { param_type: 'body' }
        requires :password, type: String, desc: 'The login password'
        requires :first_name, type: String, desc: 'User first name'
        requires :last_name, type: String, desc: 'User last name'
        optional :is_agent, type: Boolean, desc: 'flag of agent'
        optional :referral_code, type: String, desc: 'code of referrer'
      end
      post do
        result = ::Users::Create.new(
          params: declared(params, include_missing: false),
          platform: platform
        ).call
        if result.success?
          status 201
          generate_token_result = ::Users::GenerateToken.new(user: result.success).call
          token = generate_token_result.success
          format_response({ access_token: token })
        else
          error!(failure_response(*result.failure), 422)
        end
      end

      desc 'This API allows registration to the platform by metamask',
           summary: 'Metamask Register',
           success: { code: 201, model: Entities::V1::AuthenticationResponse },
           headers: {
             'Client-ID' => {
               description: 'The platform client ID',
               required: true
             }
           }
      params do
        requires :message, type: String, desc: 'Random message'
        requires :signature, type: String, desc: 'Signature signed by metamask'
        requires :wallet_address, type: String, desc: 'User wallet address'
        optional :email, type: String, regexp: URI::MailTo::EMAIL_REGEXP,
                         desc: 'The unique login email', documentation: { param_type: 'body' }
        optional :password, type: String, desc: 'The login password'
        optional :first_name, type: String, desc: 'User first name'
        optional :last_name, type: String, desc: 'User last name'
        optional :is_agent, type: Boolean, desc: 'flag of agent'
        optional :referral_code, type: String, desc: 'code of referrer'
      end
      post :metamask do
        result = ::Users::MetamaskCreate.new(
          params: declared(params, include_missing: false),
          platform: platform
        ).call
        if result.success?
          status 201
          generate_token_result = ::Users::GenerateToken.new(user: result.success).call
          token = generate_token_result.success
          format_response({ access_token: token })
        else
          error!(failure_response(*result.failure), 422)
        end
      end

      desc 'This API allows user to sign in to the platform by metamask',
           summary: 'Metamask Sign In',
           success: { code: 200, model: Entities::V1::AuthenticationResponse },
           headers: {
             'Client-ID' => {
               description: 'The platform client ID',
               required: true
             }
           }
      params do
        requires :message, type: String, desc: 'Random message'
        requires :signature, type: String, desc: 'Signature signed by metamask'
        requires :wallet_address, type: String, desc: 'User wallet address'
        optional :referral_code, type: String, desc: 'code of referrer'
      end
      post :metamask_sign_in do
        result = ::Users::MetamaskSignIn.new(
          message: params[:message],
          signature: params[:signature],
          wallet_address: params[:wallet_address],
          platform: platform
        ).call

        if result.success?
          status 200
          format_response({ access_token: result.success })
        elsif result.failure[0] == :user_not_found
          create_result = ::Users::MetamaskCreate.new(
            params: declared(params, include_missing: false),
            platform: platform,
            is_verify_signature: false
          ).call
          if create_result.success?
            status 200
            format_response({ access_token: create_result.success })
          else
            error!(failure_response(*create_result.failure), 422)
          end
        else
          error!(failure_response(*result.failure), 422)
        end
      end

      desc 'This API allows user to sign in to the platform by metamask',
           summary: 'Sign In',
           success: { code: 200, model: Entities::V1::AuthenticationResponse },
           headers: {
             'Client-ID' => {
               description: 'The platform client ID',
               required: true
             }
           }
      params do
        optional :email, type: String, regexp: URI::MailTo::EMAIL_REGEXP,
                         desc: 'The unique login email', documentation: { param_type: 'body' }
        optional :wallet_address, type: String, desc: 'User wallet address'
        requires :password, type: String, desc: 'The login password'
      end
      post :sign_in do
        result = ::Users::SignIn.new(
          email: params[:email],
          wallet_address: params[:wallet_address],
          password: params[:password],
          platform: platform
        ).call

        if result.success?
          status 200
          format_response({ access_token: result.success })
        else
          error!(failure_response(*result.failure), 422)
        end
      end

      desc 'This API allows user to create random message for metamask signup/signin',
           summary: 'Create random message',
           success: { code: 200, model: Entities::V1::RandomMessageResponse },
           headers: {
             'Client-ID' => {
               description: 'The platform client ID',
               required: true
             }
           }
      post :random_message do
        result = ::Users::GenerateMessage.call(platform)

        if result.success?
          status 200
          format_response({ message: result.success })
        else
          error!(failure_response(*result.failure), 422)
        end
      end
    end
  end
end
