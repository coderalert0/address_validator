# frozen_string_literal: true

require 'csv'
require 'smartystreets_ruby_sdk/client_builder'

describe AddressTable do
  let(:subject) { AddressTable.new }

  describe '#populate' do
    after :each do
      table = subject.instance_variable_get(:@table)
      expect(table).to eq [[csv_row.fields.join(', '), result_address]]
    end

    context 'for an invalid address' do
      let(:csv_row) { build :invalid_csv_row }
      let(:result_address) { nil }

      it 'adds an array containing the paired original address and invalid address message to the table' do
        subject.populate(csv_row)
      end
    end

    context 'for a valid address' do
      let(:csv_row) { build :valid_csv_row }
      let(:candidate) { build :candidate }
      let(:result_address) { { :delivery_line_1 => candidate.delivery_line_1,
                               :city_name => candidate.components.city_name,
                               :state_abbreviation => candidate.components.state_abbreviation,
                               :zipcode => candidate.components.zipcode,
                               :plus4_code => candidate.components.plus4_code
      } }

      it 'populates a valid address entry' do
        subject.populate(csv_row, candidate)
      end
    end
  end

  describe '#print' do
    let(:address_input) { '143 e Maine Street, Columbus, 43215' }
    let(:result_address) { '143 E Main St, Columbus, 43215-5370' }
    let(:result_address_hash) { { :city_name=>"Columbus",
                                  :delivery_line_1 => "143 E Main St",
                                  :plus4_code => "5370",
                                  :zipcode => "43215" } }
    let(:table) { [[address_input, result_address_hash]] }

    it 'correctly prints the table' do
      # setting the table since we are not concerned with the population logic here but rather that input and output match
      subject.instance_variable_set(:@table, table)
      expect { subject.print }.to output("#{address_input} -> #{result_address_hash[:delivery_line_1]}, #{result_address_hash[:city_name]}, #{result_address_hash[:zipcode]}-#{result_address_hash[:plus4_code]}\n").to_stdout
    end
  end

  context 'count displays' do
    let(:valid_address_input) { '143 e Maine Street, Columbus, 43215' }
    let(:valid_result_address) { '143 E Main St, Columbus, 43215-5370' }
    let(:invalid_address_input) { '1 Empora St, Title, 11111' }
    let(:invalid_result_address) { nil }
    let(:table) { [[valid_address_input, valid_result_address], [invalid_address_input, invalid_result_address]] }

    describe 'invalid_count_display' do
      it 'correctly returns the number of invalid addresses' do
        subject.instance_variable_set(:@table, table)
        expect { subject.invalid_count_display }.to output("Invalid Addresses count: 1\n").to_stdout
      end
    end

    describe 'valid_count_display' do
      it 'correctly returns the number of invalid addresses' do
        subject.instance_variable_set(:@table, table)
        expect { subject.valid_count_display }.to output("Valid Addresses count: 1\n").to_stdout
      end
    end
  end

  describe '#state_count_display' do
    let(:valid_ohio_1_address_input) { '143 e Maine Street, Columbus, 43215' }
    let(:valid_ohio_1_address_hash) { { :city_name=>"Columbus",
                                  :delivery_line_1 => "143 E Main St",
                                  :state_abbreviation => "OH",
                                  :plus4_code => "5370",
                                  :zipcode => "43215" } }
    let(:valid_ohio_2_address_input) { '143 e Main Street, Columbus, 43215' }
    let(:valid_ohio_2_address_hash) { { :city_name=>"Columbus",
                                        :delivery_line_1 => "143 E Main St",
                                        :state_abbreviation => "OH",
                                        :plus4_code => "5370",
                                        :zipcode => "43215" } }
    let(:table) { [[valid_ohio_1_address_input, valid_ohio_1_address_hash], [valid_ohio_2_address_input, valid_ohio_2_address_hash]] }

    it 'correctly returns the number of invalid addresses' do
      subject.instance_variable_set(:@table, table)
      expect { subject.state_count_display }.to output("State Counts\nOH: 2\n").to_stdout
    end
  end
end
