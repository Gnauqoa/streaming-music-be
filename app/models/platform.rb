# frozen_string_literal: true

class Platform < ApplicationRecord
  has_many :users
  has_many :agents
  has_one :platform_setting

  validates_presence_of :name, :client_id, :public_key, :private_key

  # after_create :create_plans

  def initialize(*args)
    super(*args)
    key = OpenSSL::PKey::RSA.new(2048)
    self.private_key = key.to_pem
    self.public_key = key.public_to_pem
    self.client_id = SecureRandom.hex unless client_id
    self.name = SecureRandom.hex unless name
  end

  def prefix_signed_message
    "Sign this message to generate your #{name} Key. This key lets the application decrypt your balance on #{name}.\n\nIMPORTANT:Only sign this message if you trust the application;"
  end

  # rails_admin do
  #   list do
  #     include_all_fields
  #     field :scope, :pg_string_array
  #   end

  #   show do
  #     include_all_fields
  #     field :hosts, :pg_string_array
  #     field :scope, :pg_string_array
  #   end

  #   edit do
  #     include_all_fields
  #     field :hosts, :pg_string_array
  #     field :scope, :pg_string_array
  #   end
  # end

  private

  def create_plans
    Plan.create(
      [
        { name: 'Basic', code: :basic },
        { name: 'Standard', code: :standard },
        { name: 'Black', code: :black }
      ].map { |plan| plan.merge(platform_id: id, active: true) }
    )
  end
end
