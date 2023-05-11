# frozen_string_literal: true

FactoryBot.define do
  # this factory returns the same object that the api response would
  factory :candidate, class: SmartyStreets::USStreet::Candidate do
    attributes = {
      'delivery_line_1' => '143 E Main St',
      'last_line' => 'Columbus OH 43215-5370',
      'components' => {
        'primary_number' => '143',
        'street_name' => 'Main',
        'street_predirection' => 'E',
        'street_suffix' => 'St',
        'city_name' => 'Columbus',
        'zipcode' => '43215',
        'plus4_code' => '5370'
      }
    }

    initialize_with { new(attributes) }
  end
end
