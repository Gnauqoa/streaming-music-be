# frozen_string_literal: true
class UsersController < ApplicationController
  def token
    generate_token_result = ::Users::GenerateToken.new(user: current_user).call
    token = generate_token_result.success
    render json: {
      data: { access_token: token }
    }
  end
end
