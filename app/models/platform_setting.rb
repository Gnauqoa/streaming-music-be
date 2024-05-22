# frozen_string_literal: true

class PlatformSetting < ApplicationRecord
  belongs_to :platform

  KEYS = [
    USE_BANKING_TIERS = 'USE_BANKING_TIERS',
    MIN_DEPOSIT_AMOUNT = 'MIN_DEPOSIT_AMOUNT',
    MAX_DEPOSIT_AMOUNT = 'MAX_DEPOSIT_AMOUNT',
    MIN_WITHDRAWAL_AMOUNT = 'MIN_WITHDRAWAL_AMOUNT',
    MAX_WITHDRAWAL_AMOUNT = 'MAX_WITHDRAWAL_AMOUNT',
    PLATFORM_TEMPLATE = 'PLATFORM_TEMPLATE',
    THEME = 'THEME',
    GLOBAL_TRANSACTION = 'GLOBAL_TRANSACTION',
    ANNOUNCEMENT_TEXT = 'ANNOUNCEMENT_TEXT',
    CRYPTO_EXCHANGE_RATE = 'CRYPTO_EXCHANGE_RATE',
    CURRENCY = 'CURRENCY',
    CRYPTO_PAYMENT = 'CRYPTO_PAYMENT',
    MISSION = 'MISSION'

  ].freeze

  DESCRIPTIONS = {
    USE_BANKING_TIERS => 'Use banking tiers',
    MIN_DEPOSIT_AMOUNT => 'Minimum deposit amount',
    MAX_DEPOSIT_AMOUNT => 'Maximum deposit amount',
    MIN_WITHDRAWAL_AMOUNT => 'Minimum withdrawal amount',
    MAX_WITHDRAWAL_AMOUNT => 'Maximum withdrawal amount',
    PLATFORM_TEMPLATE => 'Platform template',
    THEME => 'Theme of the platform'
  }.freeze

  DEFAULTS = {
    USE_BANKING_TIERS => 'false',
    MIN_DEPOSIT_AMOUNT => '0',
    MAX_DEPOSIT_AMOUNT => '100000',
    MIN_WITHDRAWAL_AMOUNT => '0',
    MAX_WITHDRAWAL_AMOUNT => '100000',
    PLATFORM_TEMPLATE => 'asia',
    THEME => 'default'
  }.freeze

  USER_ACCESSIBLE_KEYS = [
    MIN_DEPOSIT_AMOUNT,
    MAX_DEPOSIT_AMOUNT,
    MIN_WITHDRAWAL_AMOUNT,
    MAX_WITHDRAWAL_AMOUNT,
    THEME,
    GLOBAL_TRANSACTION,
    CRYPTO_EXCHANGE_RATE,
    CURRENCY,
    ANNOUNCEMENT_TEXT,
    CRYPTO_PAYMENT,
    MISSION
  ].freeze

  def self.use_banking_tiers?(platform)
    find_by(platform_id: platform.id, key: USE_BANKING_TIERS)&.value == 'true'
  end
end
