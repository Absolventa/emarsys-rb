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
