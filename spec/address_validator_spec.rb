# frozen_string_literal: true

describe AddressValidator do
  let(:subject) { AddressValidator.new }
  let(:candidate) { build :candidate }

  before :each do
    # stubbing call to client
    allow(Client).to receive_message_chain(:new, :send_request) { [candidate] }
    subject.run('sample_file.csv')
  end

  describe '#run' do
    it 'instantiates @address_table' do
      expect(subject.instance_variable_get(:@address_table)).to be_a AddressTable
    end

    it 'populates @csv_table' do
      expect(subject.instance_variable_get(:@csv_table)).to be_a CSV::Table
    end
  end
end
