token_for uses Rails 4.1's verifiers and provides an easy way of using stateless tokens in ActiveRecord models.

h1. Usage

```ruby
class User < ActiveRecord::Base
  include TokenFor

  token_for :password_reset, attributes: [:id, :email], expires_in: 2.hours
end
```

This will provide two methods

```ruby
password_reset_token
```
This will return the token generated using the specified attributes and expires_in time (which is optional)

```ruby
find_by_password_reset_token!(token)
```
This will search for a record by the specified attributes. Returns either a record or nil. If the token has expired it will raise *TokenFor::TokexExpired*.

This project rocks and uses MIT-LICENSE.
