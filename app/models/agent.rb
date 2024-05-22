# frozen_string_literal: true

class Agent < ApplicationRecord
  include Referable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :rememberable, :registerable

  validates_uniqueness_of :username, scope: :platform_id, if: -> { username.present? }
  validates_format_of :username, with: /\A[\w\d_.]*\z/i, if: -> { username.present? }

  belongs_to :platform
  has_many :users
  has_many :child_agents, class_name: 'Agent'
  belongs_to :parent_agent, class_name: 'Agent', foreign_key: :agent_id, optional: true

  has_many :game_providers_agents
  has_many :game_providers, through: :game_providers_agents
  accepts_nested_attributes_for :game_providers_agents

  alias game_percentages game_providers_agents

  has_one :settlement
  has_one :win_loss
  has_many :win_loss_details
  delegate :outstanding, to: :settlement

  before_create :set_referral_code
  after_commit :init_data, on: :create

  scope :of_platform, ->(platform_id) { where(platform_id:) }
  scope :by_tier, ->(tier) { where("tier < ?", tier) }

  TIERS = [
    COMPANY = 'COMPANY',
    SUPER_MASTER = 'SUPER_MASTER',
    MASTER = 'MASTER',
    SUPER_AGENT = 'SUPER_AGENT',
    AGENT = 'AGENT'
  ].freeze

  def initialize(*args)
    super(*args)

    self.username = "#{usernamize(platform&.name)}_#{usernamize(first_name)}_#{usernamize(last_name)}_#{SecureRandom.uuid[0..3]}" unless username
  end

  def usernamize(string)
    string.to_s.parameterize(separator: '_')
  end

  def fullname
    "#{first_name} #{last_name}"
  end

  def rank
    TIERS[tier]
  end

  def child_agent
    Agent.find_by(id: self.agent_id)
  end

  def tree_agent
    ancestors = []
    agent = self
    while agent.present?
      agent = agent.parent_agent
      ancestors << agent if agent
    end
    ancestors
  end

  def reverse_tree_agent(ancestors = [])
    child_agents.each do |child_agent|
      ancestors << child_agent
      child_agent.reverse_tree_agent(ancestors)
    end
    ancestors
  end

  private

  def set_referral_code
    self.referral_code = SecureRandom.hex
  end

  def init_data
    ActiveRecord::Base.transaction do
      create_settlement
    end
  end

  def create_win_loss_detail
    WinLossDetail.create!(turnover: 0, win_loss: 0, agent_id: id)
  end

  def create_settlement
    Settlement.create!(agent: self, outstanding: 0, count: 0)
  end

  def update_win_loss_details(game, win_loss_detail_agent, payout_before_percentage)
    win_loss_detail = WinLossDetail.find_or_create_by(user_id: id, game_id: game.id)
    win_loss_detail.update!(
      agent_id: win_loss_detail_agent.id,
      win: payout_before_percentage > 0 ? payout_before_percentage : 0,
      loss: payout_before_percentage < 0 ? -payout_before_percentage : 0,
      turnover: payout_before_percentage.abs,
      payout_before_percentage: payout_before_percentage
    )
  end
end
