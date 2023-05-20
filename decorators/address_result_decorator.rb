# frozen_string_literal: true

require_relative '../initializers/internationalization'

class AddressResultDecorator
  attr_reader :candidate

  def initialize(candidate)
    @candidate = candidate
  end

  def display
    if candidate.nil?
      nil
    else
      { :delivery_line_1  => candidate.delivery_line_1,
        :city_name => candidate.components.city_name,
        :state_abbreviation => candidate.components.state_abbreviation,
        :zipcode => candidate.components.zipcode,
        :plus4_code => candidate.components.plus4_code
      }
    end
  end
end