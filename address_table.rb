# frozen_string_literal: true
require 'pry'
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
    @table.each do |row|
      output = row[1] ? I18n.t(:address_result, **row[1]) : I18n.t(:invalid_address)
      puts "#{row[0]} -> #{output}"
    end
  end

  def invalid_count_display
    puts "Invalid Addresses count: #{@table.select { |element| element[1] == nil }.size}"
  end

  def valid_count_display
    puts "Valid Addresses count: #{@table.select { |element| element[1] != nil }.size}"
  end

  def state_count_display
    corrected_addresses = @table.delete_if { |k,v| v.nil? }
    state_counts = corrected_addresses.group_by { |k, v| v[:state_abbreviation] }.map { |k,v| [k, v.count] }
    puts I18n.t(:state_counts)
    state_counts.each { |state_count| puts "#{state_count[0]}: #{state_count[1]}" }
  end
end
