# frozen_string_literal: true

class Client
  def initialize
    # reading credentials from environment variables
    auth_id = ENV['SMARTY_AUTH_ID']
    auth_token = ENV['SMARTY_AUTH_TOKEN']
    credentials = SmartyStreets::StaticCredentials.new(auth_id, auth_token)

    @client_builder = SmartyStreets::ClientBuilder.new(credentials)
                                                  .with_licenses(['us-core-cloud'])
                                                  .build_us_street_api_client
  end

  def send_request(csv_row)
    lookup = SmartyStreets::USStreet::Lookup.new
    lookup.match = SmartyStreets::USStreet::MatchType::STRICT
    lookup.street = csv_row['Street']
    lookup.city = csv_row['City']
    lookup.zipcode = csv_row['Zip Code']

    @client_builder.send_lookup(lookup)
    lookup.result
  end
end
