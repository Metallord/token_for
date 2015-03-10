token_for uses Rails 4.1's verifiers and provides an easy way of using stateless tokens in ActiveRecord models.

#Usage

```ruby
class User < ActiveRecord::Base
  include TokenFor

  token_for :password_reset, attrs: [:id, :email], expires_in: 2.hours
end
```
This will provide two methods
```ruby
password_reset_token # This will return the token generated using the specified attributes and expires_in time (which is optional)
```

```ruby
find_by_password_reset_token!(token) #This will search for a record by the specified attributes. Returns either a record or nil. If the token has expired it will raise *TokenFor::TokenExpired*.
```

There is also the `one_time_use` option which defaults to true and includes the model's `updated_at` attribute in the token so that it's invalidated when the model changes. You can set this as false and provide your own attribute which will accomplish this.

This project rocks and uses MIT-LICENSE.
