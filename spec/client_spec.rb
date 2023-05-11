# frozen_string_literal: true

describe Client do
  let(:subject) { Client.new }
  let(:csv_row) { CSV::Row.new(['Street', 'City', 'Zip Code'], address) }
  let(:address) { ['143 e Maine Street', 'Columbus', 43_215] }

  describe '#initialize' do
    it 'instantiates @client_builder' do
      # stubbing the client
      allow(SmartyStreets::ClientBuilder).to receive_message_chain(:new, :with_licenses, :build_us_street_api_client) {
                                               SmartyStreets::USStreet::Client.new(nil, nil)
                                             }
      subject.send(:initialize)
      expect(subject.instance_variable_get(:@client_builder)).to be_a SmartyStreets::USStreet::Client
    end
  end

  describe '#send_request' do
    it 'calls send_lookup' do
      expect(subject.instance_variable_get(:@client_builder)).to receive(:send_lookup)
      subject.send_request(csv_row)
    end

    it 'returns a candidate object' do
      expect(subject.send_request(csv_row)[0]).to be_a SmartyStreets::USStreet::Candidate
    end
  end
end
