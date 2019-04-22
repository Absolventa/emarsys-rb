# emarsys-rb [![Build Status](https://travis-ci.org/Absolventa/emarsys-rb.svg?branch=master)](https://travis-ci.org/Absolventa/emarsys-rb)

Simple Ruby wrapper for the Emarsys API.

## Installation

    gem install emarsys

## Emarsys API Hint

This wrapper tries to implement all available methods of the Emarsys API in a
Ruby-like fashion. However, the Emarsys API lacks a decent amount of methods that
you expect an API to provide.
Thus, if methods are missing or a certain implementation
style was choosen it is most likely due to the inconsistency of the API itself.
Feel free to get in touch or submit a pull request if you encounter any problems.

Must-known facts about the Emarsys API:

* Emarsys uses internal IDs as field identifiers. E.g. 'email' is mapped to the value 3.
This gem tries to work around this by letting you specify a field mapping constant.
* certain methods require the specification of a key-field, e.g. the email (internally refered to as '3' again).
* Return values differ from method to method due to the way the Emarsys API is implemented.
Thus, a Hash as a return value or an Array of Hashes was choosen as the global return object. Basically it is a parsed JSON response.
* Please refer to the Emarsys API documentation for detailed information on parameters, return values or error codes.
* The list of available countries is defined by Emarsys, and uses internal Emarsys-specific IDs.  A utility class is
provided to map [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2 "ISO 3166-1 alpha-2") data (aka 2-letter country codes) to internal Emarsys country IDs.

## Configuration and Setup
### Authentication

Authenticate with the api credentials provided by your Emarsys account manager.

```ruby
Emarsys.configure do |c|
  c.api_username = 'my_username'
  c.api_password = 'my_password'
  # OPTIONAL, defaults to https://api.emarsys.net/api/v2
  c.api_endpoint = 'https://suite5.emarsys.net/api/v2'
end
```

It is also possible to configure multiple Emarsys accounts like this:

```ruby
Emarsys.configure(account: :foo) do |c|
  c.api_username = 'foo_username'
  c.api_password = 'foo_password'
end

Emarsys.configure(account: :bar) do |c|
  c.api_username = 'bar_username'
  c.api_password = 'bar_password'
end
```

When your application uses only one Emarsys account you will need to add:

```ruby
Emarsys.allow_default_configuration = true
```

to your configuration.

### Field Mapping

As said before, Emarsys loves IDs. For using an API, they are evil. This gem provides
an easy way to adjust the individual field settings. Internally a Ruby Mapping Constant is used,
which that can be overwritten. It will be picked up automatically. E.g.:

```ruby
# Complete overwrite
Emarsys::FieldMapping.set_attributes([
  {:id => 0, :identifier => 'interests', :name => 'Interests'},
  {:id => 1, :identifier => 'firstname', :name => 'First Name'},
  {:id => 2, :identifier => 'lastname',  :name => 'Last Name'},
])

# Add to the Mapping-Constant
Emarsys::FieldMapping.add_attributes({:id => 100, :identifier => 'user_id', :name => "User-ID"})
```

All Emarsys predefined system fields are prefixed with an underscore, e.g. '_firstname' or '_revenue' in order to not
clash with individual mappings.

### Mapping Country IDs from ISO country codes

A utility method is provided to map to Emarsys internal country IDs from ISO 3166-1 alpha-2 two-letter country codes.  You can pass a symbol or a string, and case is ignored.

```ruby
>> Emarsys::Country.from_iso('GB')
=> {:id=>184, :name=>"United Kingdom"}

>> Emarsys::Country.from_iso(:af)
=> {:id=>1, :name=>"Afghanistan"}

>> Emarsys::Country.from_iso('us')
=> {:id=>185, :name=>"United States of America"}
```

### Rate Limiting

The Emarsys API documentation states you can make "at least 200 requests per minute", which is reasonably slow - in practice, the Emarsys API seems to handle rates of up to about 60-70 req/sec before complaining.

If you exceed the limit, the Emarsys API returns an HTTP 429 'Too Many Requests' response. The client library will raise an error in this case.



## Interacting with the API

### Responses

Each API request returns a response object, which exposes the following methods:

* `code`: HTTP status code
* `text`: 'replyText' from parsed JSON
* `data`: 'data' from parsed JSON
* `code`: 'replyCode' from parsed JSON

If the `replyCode` is not `0`, an exception will be raised.

### Multiple accounts
If you configured multiple Emarsys accounts, you will need to pass the keyword
argument `account` to every API call, e.g.
`Emarsys::Condition.collection(account: :foo)`.


### Endpoints

#### Condition

```ruby
# Get all conditions
Emarsys::Condition.collection
```

#### Contact

```ruby
# Create a contact with custom key_field (one example with mapped identifier, one without)
Emarsys::Contact.create(key_id: 'user_id', key_value: 10, params: {firstname: "Jane", lastname: "Doe", email: "jane.doe@example.com"})
Emarsys::Contact.create(key_id: 4980, key_value: 10, params: {1 => "Jane", 2 => "Doe", 3 => "jane.doe@example.com"})

# Update a contact with key_field (one example with mapped identifier, one without)
Emarsys::Contact.update(key_id: 'email', key_value: "jane.doe@example.com", params: {firstname: "John", lastname: "Doe"})
Emarsys::Contact.update(key_id: 3, key_value: "jane.doe@example.com", params: {1 => "John", 2 => "Doe"})

# Query contact information
Emarsys::Contact.query('3', 'john.doe@example.com', 'uid')
```


#### ContactList

```ruby
# Get all contact_lists
Emarsys::ContactList.collection

# Create a contact list
Emarsys::ContactList.create

# Delete a contact list
Emarsys::ContactList.delete(123)
```

#### Emails

```ruby
# Get all email campaigns, optional filter
Emarsys::Email.collection
Emarsys::Email.collection(status: 3)

# Get a single email resource
Emarsys::Email.resource(1)

# Create a new email campaign
Emarsys::Email.create

Emarsys::Email.launch(1)
```

#### Event

```ruby
Emarsys::Event.collection

# Trigger a custom event
Emarsys::Event.trigger(65, key_id: 3, external_id: "test@example.com")

# Trigger a custom event which actually sends a mail
# (Emarsys way to send transactional mails with placeholders)
Emarsys::Event.trigger(2, key_id: 3, external_id: 'test@example.com', data: {:global => {:my_placeholder => "some content"}})
```

#### Export

```ruby
Emarsys::Export.resource(1)
```

#### Field

```ruby
Emarsys::Field.collection
Emarsys::Field.choice(1)
```

#### Folder

```ruby
# Get all forms, optional filter parameters
Emarsys::Folder.collection
Emarsys::Folder.collection(folder: 3)
```

#### Form

```ruby
# Get all forms
Emarsys::Form.collection
```

#### Language

```ruby
# Get all languages
Emarsys::Language.collection
```

#### Segment

```ruby
# Get all segments
Emarsys::Segment.collection
```

```ruby
# List contacts in a segment
Emarsys::Segment.contacts(123, limit: 2000)
```

#### Source

```ruby
# Get all sources
Emarsys::Source.collection

# Create a new source
Emarsys::Source.create(name: "New Source")

# Destroy a source
Emarsys::Source.destroy(123)
```

Please refer to the code for detailed instructions of each method.



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Copyright

Copyright (c) 2013 Daniel Schoppmann. See LICENSE.txt for details.
