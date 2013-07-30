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

As said before, Emarsys loves IDs. For using an APi, they are evil. This Gem provides
an easy way to adjust the individual field settings. Internally there is a Ruby Constant,
that can be overwritten, the mapping will be picked up automatically. E.g.:

    $  # Complete overwrite
    $  Emarsys::FieldMapping::ATTRIBUTES = [
    $    {:id => 0,   :identifier => 'interests',                  :name => 'Interests'},
    $    {:id => 1,   :identifier => 'first_name',                 :name => 'First Name'},
    $    {:id => 2,   :identifier => 'last_name',                  :name => 'Last Name'},
    $  ]

    $  # Complete overwrite
    $  Emarsys::FieldMapping::ATTRIBUTES << {:id => 100, :identifier => 'age', :name => "Age"}


## Interacting with the API
### Condition

    $ Emarsys::Language.collection

### Contact

    $ Emarsys::Contact.create
    $ Emarsys::Contact.update

### ContactList

    $ # Get all contact_lists
    $ Emarsys::ContactList.collection
    $
    $ # Create a contact list
    $ Emarsys::ContactList.create

### Emails

    $ Emarsys::Email.collection
    $ Emarsys::Email.collection(:status => 3)
    $ Emarsys::Email.resource(1)
    $ Emarsys::Email.create({})
    $ Emarsys::Email.launch({})

### Event

    $ Emarsys::Event.collection
    $ Emarsys::Event.trigger(65, 3, ["test@example.com"])

### Export

    $ Emarsys::Export.resource(1)

### Field

    $ Emarsys::Field.collection
    $ Emarsys::Field.choice(1)

### Folder

    $ Emarsys::Folder.collection
    $ Emarsys::Folder.collection(:folder => 3)

### Form

    $ Emarsys::Form.collection

### Language

    $ Emarsys::Language.collection

### Segment

    $ Emarsys::Segment.collection

### Source

    $ Emarsys::Source.collection
    $ Emarsys::Source.create("New Source")
    $ Emarsys::Source.destroy(123)

Please refer to the code easir understand of each method.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Copyright

Copyright (c) 2013 Daniel Schoppmann. See LICENSE.txt for details.