# frozen_string_literal: true
module Emarsys

  # Methods for the Segment API
  #
  #
  class Segment < DataObject
    class << self

      # List segments
      #
      # @return [Hash] List of segments
      # @example
      #   Emarsys::Segment.collection
      def collection(account: nil)
        get account, 'filter', {}
      end

    end
  end

end
