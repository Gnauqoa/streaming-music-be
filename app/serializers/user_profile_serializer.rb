# frozen_string_literal: true

class UserProfileSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :first_name, :last_name, :created_at, :updated_at,:current_sign_in_at, :current_sign_in_ip
end
