# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :avatar_url, :birth, :email, :first_name, :last_name, :created_at, :updated_at
  def avatar_url
    return object.avatar_url if object.avatar_url.present?
    "https://i.scdn.co/image/ab6761610000e5eb3bcc23d31e8962897b7d3e2c"
  end
end
