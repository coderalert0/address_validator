# frozen_string_literal: true

FactoryBot.define do
  factory :valid_csv_row, class: CSV::Row do
    header { ['Street', 'City', 'Zip Code'] }
    fields { ['143 e Maine Street', 'Columbus', 43215] }

    initialize_with { new(header, fields) }
  end

  factory :invalid_csv_row, class: CSV::Row do
    header { ['Street', 'City', 'Zip Code'] }
    fields { ['1 Empora St', 'Title', 11111] }

    initialize_with { new(header, fields) }
  end
end
