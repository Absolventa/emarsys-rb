# Emarsys

Simple Ruby wrapper for the Emarsys API.

## Installation

    $ gem install emarsys

## Emarsys API Hint

This wrapper tries to implement all available methods of the Emarsys API in a
Ruby-like manner. However, the Emarsys API lacks a decent amount of methods.
Thus, if methods are missing or a certain implementation
style was chossen it is most likely due to the inconsistency of the API itself.
Feel free to get in touch or submit a pull request if something is missing.

Must-known facts about the Emarsys API:
* all data_fields must be specified with the internal Emarsys-ID. E.g. "first_name"
defaults to "1", last_name defaults to "2" etc.
* certain methods require the specification of a key-field. It defaults to the Emarsys default
("3" - internally it is called email)
* It is due to the Emarsys API, they usally do not provide a way to access single resources
* return values differ from method to method. Thus, a Hash or Array of Hashes was choosen
as the global return object

## Configuration and Setup
### Authentication

    $ Emarsys.configure do |c|
    $   c.api_username = 'my_username'
    $   c.api_password = 'my_password'
    $   c.api_endpoint = 'https://www.emarsys.net/api/v2' # OPTIONAL, defaults to https://suite5.emarsys.net/api/v2
    $ end

### Field Mapping


## Interacting with the API
### Condition

    $ Emarsys::Language.collection

### Contact

    $ Emarsys::Contact.create
    $ Emarsys::Contact.update

### Emails

    $ Emarsys::Email.collection
    $ Emarsys::Email.collection(:status => 3)
    $ Emarsys::Email.resource(1)

### Event

    $ Emarsys::Event.collection
    $ Emarsys::Event.trigger(65, 3, ["test@example.com"])

### Form

    $ Emarsys::Form.collection

### Language

    $ Emarsys::Language.collection

### Sources

    $ Emarsys::Source.collection
    $ Emarsys::Source.create(:name => "New Source")
    $ Emarsys::Source.destroy(123)

Please refer to the code for more method. It should be quite easy to understand.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request