require 'test_helper'

describe TokenFor do

  # TODO Actually test the find_by_whatever_token! method
  describe 'with expires_in' do
    let(:example_class) { ExampleWithoutExpiresIn }
    let(:example_class_with_expired_token) { ExampleWithExpiredToken }
    let(:token) { example_class.new(test_attribute: 'user@example.com').test_token }
    let(:expired_token) { example_class_with_expired_token.new(test_attribute: 'user@example.com').test_token }

    it('generates token') { token.wont_be_nil }

    it 'properly verifies the token if active' do
      example_class.verifier_for(:test).verify(token).values.must_include 'user@example.com'
    end

    it 'raises TokenExpired if the token has expired' do
      # The expires_on key must be in the token
      example_class_with_expired_token.verifier_for(:test).verify(expired_token).keys.must_include :expires_on
      # must_raise needs such syntax
      ->{example_class_with_expired_token.find_by_test_token!(expired_token)}.must_raise TokenFor::TokenExpired
    end
  end

  describe 'without expires_in' do
    let(:example_class) { ExampleWithoutExpiresIn }
    let(:token) { example_class.new(test_attribute: 'user@example.com').test_token }

    it('generates token') { token.wont_be_nil }

    it 'properly verifies the token' do
      example_class.verifier_for(:test).verify(token).must_equal test_attribute: 'user@example.com'
    end
  end
end