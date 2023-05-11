# frozen_string_literal: true

require_relative 'decorators/address_result_decorator'

class AddressTable
  def initialize
    @table = []
  end

  def populate(csv_row, address_result = nil)
    address_input = I18n.t(:address_input,
                           street: csv_row['Street'],
                           city: csv_row['City'],
                           zipcode: csv_row['Zip Code'])

    address_output = AddressResultDecorator.new(address_result).display
    @table << [address_input, address_output]
  end

  def print
    @table.each { |row| puts "#{row[0]} -> #{row[1]}" }
  end
end
