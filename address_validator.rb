# frozen_string_literal: true

require_relative 'address_table'
require_relative 'client'
require_relative 'csv_processor'
require_relative 'initializers/internationalization'
require 'smartystreets_ruby_sdk/static_credentials'
require 'smartystreets_ruby_sdk/client_builder'
require 'smartystreets_ruby_sdk/us_street/lookup'

class AddressValidator
  def run(filepath = ARGV[0])
    @address_table = AddressTable.new
    @csv_table = CSVProcessor.new.load(filepath)

    # send request to client for each address
    client = Client.new
    @csv_table.each do |csv_row|
      begin
        results = client.send_request(csv_row)
      rescue SmartyStreets::SmartyError => e
        puts e
        return
      end

      # populate address table with result
      @address_table.populate(csv_row, results[0]) if results
    end

    # display results to stdout
    @address_table.print
  end
end

# only executes if run from the command line
AddressValidator.new.run if __FILE__ == $PROGRAM_NAME
