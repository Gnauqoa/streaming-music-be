# frozen_string_literal: true

module We
  def self.table_name_prefix
    'we_'
  end

  class GameCategory < ApplicationRecord
    scope :active, -> { where(active: true) }
  end
end
