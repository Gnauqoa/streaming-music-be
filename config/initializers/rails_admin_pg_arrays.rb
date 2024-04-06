# frozen_string_literal: true

class RailsAdminPgArray < RailsAdmin::Config::Fields::Base
  register_instance_option :formatted_value do
    value.join(',')
  end
end

class RailsAdminPgStringArray < RailsAdminPgArray
  def parse_input(params)
    params[name] = params[name].split(',') if params[name].is_a?(::String)
  end
end

class RailsAdminPgIntArray < RailsAdminPgArray
  def parse_input(params)
    params[name] = params[name].split(',').collect(&:to_i) if params[name].is_a?(::String)
  end
end

RailsAdmin::Config::Fields::Types.register(:pg_string_array, RailsAdminPgStringArray)
RailsAdmin::Config::Fields::Types.register(:pg_int_array, RailsAdminPgIntArray)
