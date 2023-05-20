# frozen_string_literal: true

describe AddressResultDecorator do
  let(:subject) { AddressResultDecorator.new(candidate) }

  context 'when there is a candidate (result)' do
    let(:candidate) { build :candidate }

    it 'displays the corrected address' do
      expect(subject.display).to eq({ :city_name=>"Columbus",
                                      :delivery_line_1 => "143 E Main St",
                                      :state_abbreviation => nil,
                                      :plus4_code => "5370",
                                      :zipcode => "43215" })
    end
  end

  context 'when there is not a candidate (result)' do
    let(:candidate) { }

    it 'displays invalid address message' do
      expect(subject.display).to eq nil
    end
  end
end