# frozen_string_literal: true
module Emarsys

  # Methods for the Condition API
  #
  #
  class Condition < DataObject
    class << self

      # List conditions
      #
      # @return [Hash] List of conditions
      # @example
      #   Emarsys::Condition.collection
      def collection(account: nil)
        get account, 'condition', {}
      end
    end

  end
end
