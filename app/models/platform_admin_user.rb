# frozen_string_literal: true

class PlatformAdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  validates_uniqueness_of :username, scope: :platform_id, if: -> { username.present? }
  validates_format_of :username, with: /\A[\w\d_.]*\z/i, if: -> { username.present? }

  belongs_to :platform

  def initialize(*args)
    super(*args)
    self.username = "#{usernamize(platform.name)}_#{SecureRandom.uuid[0..3]}"
    self.password = SecureRandom.uuid
  end

  def usernamize(string)
    string.to_s.parameterize(separator: '_')
  end
end
