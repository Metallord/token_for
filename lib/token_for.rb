module TokenFor
  extend ActiveSupport::Concern

  class TokenExpired < StandardError; end

  module ClassMethods

    def token_for subject, attrs: [], options = {}
      options.merge!(expires_in: nil, one_time_use: true)

      # A method for generating the token
      define_method("#{subject}_token") do
        verifier = self.class.verifier_for(subject)
        attr_hash = {} # The attributes need to be in a hash
        attrs.map { |a| attr_hash.merge! a.to_sym => self.read_attribute(a) }
        attr_hash.merge!(updated_at: self.updated_at) if options[:one_time_use]
        attr_hash.merge!(expires_on: Time.zone.now + options[:expires_in]) if options[:expires_in]
        # Generate based on actual values of attributes.
        verifier.generate(attr_hash)
      end

      # Finds the record based on token. Raises TokenExpired if needed
      define_singleton_method("find_by_#{subject}_token!") do |token|
        attributes = self.verifier_for(subject).verify(token)
        raise TokenExpired if attributes[:expires_on] && attributes[:expires_on] < Time.zone.now
        self.find_by(attributes.except(:expires_on))
      end
    end

    # FIXME: This probably shouldn't be public api
    def verifier_for(purpose)
      @verifiers ||= {}
      @verifiers.fetch(purpose) do |p|
        @verifiers[p] = Rails.application.message_verifier("#{self.name}-#{p.to_s}")
      end
    end
  end
end
