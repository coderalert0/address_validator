
# Address Validator

This project validates US Addresses inputted as a CSV file against the Smarty API and returns a corrected address when available.
The design of the application is broken into the following logical components: `AddressTable, AddressValidator, Client, CSVProcessor, AddressResultDecorator`

## Class Design

**AddressTable:** A simple data structure representing the user input and Smarty API output, there underlies an array containing array pairs representing each input address and the corrected address if found

eg. `[['143 e Maine Street, Columbus, 43215', '143 E Main St, Columbus, 43215-5370'], ['1 Empora St, Title, 11111', 'Invalid Address']]`

**AddressValidator:** This is the entry point of the application and contains the flow control logic, from reading the CSV file, making a request against the Smarty API, populating the results into the AddressTable data structure, and ultimately printing the results

**Client:** Initializes a client and responsible for making Smarty API requests

**CSVProcessor**: A simple utility class responsible for loading the CSV file to a CSV::Table object

**AddressResultDecorator**: This is a utility class to separate out presentation logic, this follows the decorator pattern.

## Directory Structure
**config/locales:** Contains the translation file. It is a best practice to keep static text in such a file rather than hard-coding it. It promotes DRY code and potential support for other languages in the future.

**decorators**: Contains decorator classes which follow the presenter design pattern. The purpose is to separate out presentation logic from non-presentation logic which promotes modular design and simpler unit tests.

**spec**: Contains unit tests. Unit tests were written for every class method, both negative and positive test cases. The unit tests requiring calls to the API are stubbed 

**spec/factories**: Contains factories for creating test data using the FactoryBot gem. Factories promote DRY code by defining test data in one place which can be reused across tests.

## Environment Variables

To run this project, you will need to add the following environment variables to your environment

`SMARTY_AUTH_ID`

`SMARTY_AUTH_TOKEN`

To add an environment variable the following can be run from the command line

`export SMARTY_AUTH_ID=1234567890`

`export SMARTY_AUTH_TOKEN=abcdefg`

## Running Locally

Clone the project

```bash
  git clone https://github.com/coderalert0/address_validator.git
```

Go to the project directory

```bash
  cd address_validator
```

Install dependencies

```bash
  bundle install
```

Execute the script

```bash
  ruby address_validator.rb sample_file.csv
```

Actual output
```bash
143 e Maine Street, Columbus, 43215 -> 143 E Main St, Columbus, 43215-5370
1 Empora St, Title, 11111 -> Invalid Address
```

## Running Tests

To run tests, run the following command

```bash
  rspec spec
```