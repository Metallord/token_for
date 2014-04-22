class ExampleWithExpiresIn < Example
  token_for :test, attributes: [:test_attribute], expires_in: 2.hours
end