module Emarsys

  # Internal helper class for valid email status codes.
  # Emarsys has no implementation for this data resource.
  #
  class EmailStatusCode < DataObject

    CODES = [
      {'1'   => 'In design'},
      {'2'   => 'Tested'},
      {'3'   => 'Launched'},
      {'4'   => 'Ready to launch'},
      {'-3'  => 'Deactivated'}
    ]

    class << self

      # List email status codes
      #
      # @return [Hash] List of email status codes
      # @example
      #   Emarsys::EmailStatusCode.collection
      def collection
        CODES
      end

      # Get a specific email status codes
      #
      # @param [Integer, String] key of the code
      # @return [Hash] Key value-Pair of the status code
      # @example
      #   Emarsys::EmailStatusCode.resource('1')
      def resource(id)
        CODES.select{|hash| hash.has_key?(id.to_s)}[0]
      end
    end

  end
end