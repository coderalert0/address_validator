# frozen_string_literal: true

describe CSVProcessor do
  let(:subject) { CSVProcessor.new }

  describe '#load' do
    it 'returns an error when filepath not provided' do
      expect { subject.load(nil) }.to raise_error(RuntimeError, /Please provide an input file as an argument/)
    end

    it 'returns a csv table object when filepath is provided' do
      expect(subject.load('sample_file.csv')).to be_a CSV::Table
    end
  end
end
