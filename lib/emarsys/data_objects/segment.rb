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
      # Raises Emarsys::SegmentIsEvaluated if the segment is being currently evaluated.
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

      # Run a Segment for Multiple Contacts
      # Reference: https://dev.emarsys.com/v2/segments/run-a-contact-segment-batch
      #
      # @param id [Integer] the id of the segment
      def run(id, account: nil)
        path = "filter/#{id}/runs"
        post account, path, {}
      end

      # Poll the Status of a Segment Run for Multiple Contacts
      # Reference: https://dev.emarsys.com/v2/segments/poll-the-status-of-a-segment-run-for-multiple-contacts
      #
      # @param run_id [Integer] the id of the segment run, @see #run
      def status(run_id, account: nil)
        path = "filter/runs/#{run_id}"
        get account, path, {}
      end
    end
  end

end
