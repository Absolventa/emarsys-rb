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

      # List ids of contacts in a segment.
      # This may return HTTP 202 {"replyCode":10001,"replyText":"The segment is currently evaluated.","data":""}
      # if the segment is being currently processed.
      # Reference: https://dev.emarsys.com/v2/response-codes/http-202-errors
      # The `limit` param is required by this endpoint although it is marked as optional in the API v2 doc.
      #
      # @param id [Integer] the id of the segment
      # @param limit [Integer] the maximum number of records to return
      # @param offset [Integer] optional offset value for pagination
      def contacts(id, limit:, offset: 0, account: nil)
        path = "filter/#{id}/contacts"
        get account, path, limit: limit, offset: offset
      end
    end
  end

end
