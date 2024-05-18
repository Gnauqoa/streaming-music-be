class Artist < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_username, against: [:username]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :omniauthable, :trackable

  has_many :music_artists, dependent: :destroy
  has_many :musics, through: :music_artists, source: :music
  validates_format_of :email, with: Devise.email_regexp, if: -> { email.present? }

  def initialize(*args)
    super(*args)
  end

  def self.from_omniauth(auth)
    return unless auth.info.email

    where(email: auth.info.email).first_or_create! do |artist|
      artist.email = auth.info.email

      artist.password ||= Devise.friendly_token[0, 20]
    end
  end
end
