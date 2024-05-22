# frozen_string_literal: true

class Asset < ApplicationRecord
  has_one_attached :image

  belongs_to :platform
  enum status: {
    disabled: 0,
    active: 1
  }
  def image_url
    return nil if location.nil?

    "#{ENV['ASSETS_CDN_URL']}/#{location}"
  end
end
