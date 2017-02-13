# frozen_string_literal: true
module Emarsys

  # Methods for the Export API
  #
  #
  class Export < DataObject
    class << self

      # Find a specific export
      #
      # @param id [Integer, String] The internal emarsys id
      # @return [Hash] Result data
      # @example
      #   Emarsys::Export.resource(2)
      def resource(id)
        get "export/#{id}", {}
      end

      # Download export data
      #
      # @param id [Integer, String] The internal emarsys id
      # @option offset [Integer] Defines the ID to start listing from
      # @option limit [Integer] Defines how many IDs are listed
      # @return [String] text/csv
      # @example
      #   Emarsys::Export.data(2)
      def data(id, offset = nil, limit = nil)
        params = {}
        params.merge!(:offset => offset) if offset
        params.merge!(:limit => limit) if limit
        get "export/#{id}/data", params
      end
    end

  end

end
