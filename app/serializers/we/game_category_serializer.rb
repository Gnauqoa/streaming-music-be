# frozen_string_literal: true

module We
  class GameCategorySerializer < ActiveModel::Serializer
    attributes :id, :name, :code, :active
  end
end
