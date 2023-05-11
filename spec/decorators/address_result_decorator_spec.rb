# frozen_string_literal: true

describe AddressResultDecorator do
  let(:subject) { AddressResultDecorator.new(candidate) }

  context 'when there is a candidate (result)' do
    let(:candidate) { build :candidate }

    it 'displays the corrected address' do
      expect(subject.display).to eq '143 E Main St, Columbus, 43215-5370'
    end
  end

  context 'when there is not a candidate (result)' do
    let(:candidate) { }

    it 'displays invalid address message' do
      expect(subject.display).to eq 'Invalid Address'
    end
  end
end