# frozen_string_literal: true

require 'csv'
require_relative 'initializers/internationalization'

class CSVProcessor
  def load(file_path)
    if file_path.nil?
      raise(I18n.t(:input_error))
    else
      # parsing the csv upon handling whitespace
      CSV.parse(File.read(file_path),
                headers: true,
                :header_converters => -> (f) { f.strip},
                :converters => -> (f) { f ? f.strip : nil })
    end
  end
end
