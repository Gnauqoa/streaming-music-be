# frozen_string_literal: true

class User < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_username, against: [:username]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :omniauthable, :trackable,
         omniauth_providers: %i[facebook google_oauth2 twitter2]

  validates_uniqueness_of :email, scope: :platform_id, if: -> { email.present? }
  validates_format_of :email, with: Devise.email_regexp, if: -> { email.present? }
  validates_uniqueness_of :username, scope: :platform_id, if: -> { username.present? }
  validates_format_of :username, with: /\A[\w\d_.]*\z/i, if: -> { username.present? }
  validates_uniqueness_of :wallet_address, scope: :platform_id, if: -> { wallet_address.present? }

  belongs_to :platform
  belongs_to :agent

  has_many :user_bonus_programs
  has_many :wallets
  has_many :user_records
  has_many :user_transactions
  has_many :game_transactions
  has_one :win_loss
  has_many :win_loss_details
  has_many :games_users
  has_many :bet_results
  has_many :assigned_wallets
  has_many :we_recent_games, class_name: 'We::RecentGame'
  # after_create :create_user_wallets
  # after_create :create_win_loss

  has_one :telegram_auth
  accepts_nested_attributes_for :telegram_auth

  after_create :create_win_loss_detail
  before_create :set_deposit_message

  scope :of_platform, ->(platform_id) { where(platform_id:) }

  def initialize(*args)
    super(*args)
    self.username = SecureRandom.hex[0..19] unless username
  end

  def self.from_omniauth(auth, platform)
    username = auth.info.nickname || auth.info.email&.split('@')&.first
    if auth.info.email
      where(email: auth.info.email, platform:).first_or_create! do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.username = username
        user.password ||= Devise.friendly_token[0, 20]
      end
    else
      where(username:, platform:).first_or_create! do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.username = username
        user.password ||= Devise.friendly_token[0, 20]
      end
    end
  end

  def wallet_of(symbol)
    wallets.where(currency_id: Currency.find_by_symbol(symbol).id)
  end

  def wallet_balance
    user_records.latest.first&.balance.to_d
  end

  alias balance wallet_balance

  def current_bonus_program
    return user_bonus_programs.last if in_bonus_program

    nil
  end

  def total_deposit_amount
    user_transactions.deposit.sum(:amount)
  end

  def statement
    turnover = win_loss_details.sum(:turnover)
    win_loss = win_loss_details.sum(:win_loss)

    {
      win_loss: {
        turnover:,
        debit: turnover,
        credit: win_loss + turnover
      },
      transaction: {
        credit: user_transactions.deposit.success.sum(:amount),
        debit: user_transactions.withdraw.success.sum(:amount),
        balance: wallet_balance
      }
    }
  end

  private

  def create_user_wallets
    currencies = Currency.active

    currencies.each do |currency|
      Wallets::CreateErc20Wallet.call(user: self, currency:, params: {})
    end
  end

  def create_win_loss_detail
    # WinLoss.create(user: self, turnover: 0, win_loss: 0)
    WinLossDetail.create(user: self, turnover: 0, win_loss: 0)
  end

  def set_deposit_message
    self.deposit_message = "FT#{rand(2**32..2**33 - 1)}"
  end
end
