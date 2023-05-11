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
      let(:result_address) { 'Invalid Address' }

      it 'adds an array containing the paired original address and invalid address message to the table' do
        subject.populate(csv_row)
      end
    end

    context 'for a valid address' do
      let(:csv_row) { build :valid_csv_row }
      let(:candidate) { build :candidate }
      let(:result_address) do
        "#{candidate.delivery_line_1}, #{candidate.components.city_name}, #{candidate.components.zipcode}-#{candidate.components.plus4_code}"
      end

      it 'populates a valid address entry' do
        subject.populate(csv_row, candidate)
      end
    end
  end

  describe '#print' do
    let(:address_input) { '143 e Maine Street, Columbus, 43215' }
    let(:result_address) { '143 E Main St, Columbus, 43215-5370' }
    let(:table) { [[address_input, result_address]] }

    it 'correctly prints the table' do
      # setting the table since we are not concerned with the population logic here but rather that input and output match
      subject.instance_variable_set(:@table, table)
      expect { subject.print }.to output("#{address_input} -> #{result_address}\n").to_stdout
    end
  end
end
