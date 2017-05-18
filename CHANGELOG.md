# Changelog

## v0.3.3

* Fix Tunisia country code ([#34](https://github.com/Absolventa/emarsys-rb/pull/34))

## v0.3.2

* Contact deletion ([#33](https://github.com/Absolventa/emarsys-rb/pull/33))

## v0.3.1

* Export segment ([#31](https://github.com/Absolventa/emarsys-rb/pull/31))

## v0.3.0

* Return response, not just (parsed) body of it ([#29](https://github.com/Absolventa/emarsys-rb/pull/29)). To migrate existing code, you need to call `#data` on the
response object.
* Allow to configure multiple Emarsys accounts. This is optional, existing configuration continues to work unchanged, however, you will need to add `Emarsys.allow_default_configuration = true` ([#30](https://github.com/Absolventa/emarsys-rb/pull/30))
* Migrate API calls to keyword arguments (also in [#30](https://github.com/Absolventa/emarsys-rb/pull/30))

## v0.2.3

* Convert params when using the batch APIs ([#25](https://github.com/Absolventa/emarsys-rb/pull/25))

## v0.2.2

* Allow batch updates to create missing contacts ([#22](https://github.com/Absolventa/emarsys-rb/pull/22))
* Add support for the data export API ([#23]((https://github.com/Absolventa/emarsys-rb/pull/23))

## v0.2.1

* Added basic support for rate-limiting response from Emarsys API ([#21](https://github.com/Absolventa/emarsys-rb/pull/21))

## v0.2.0
* Added country mapping ([#17](https://github.com/Absolventa/emarsys-rb/pull/17))
* Proper encoding of GET parameters ([#11](https://github.com/Absolventa/emarsys-rb/pull/11))
* Update default endpoint fom `suite5.emarsys.net/api/v2` to `api.emarsys.net/api/v2` ([#10](https://github.com/Absolventa/emarsys-rb/pull/10))
* Bugfixes in nonce header ([#5](https://github.com/Absolventa/emarsys-rb/pull/5) and [#19](https://github.com/Absolventa/emarsys-rb/pull/19))
* Trigger an external event for multiple contacts ([#3](https://github.com/Absolventa/emarsys-rb/pull/3))

## v0.1.0

Initial version
